import Speech

import Domain

public actor SpeechRecognizeServiceImpl: SpeechRecognizeService {
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer = SFSpeechRecognizer()
    
    @MainActor public weak var delegate: SpeechRecognizeServiceDelegate?
    
    public init() { }
    
    @MainActor public func startTranscribe() {
        Task {
            await transcribe()
        }
    }
    
    @MainActor public func stopTranscribe() {
        Task {
            await reset()
        }
    }
    
    nonisolated private func transcribe(_ message: String) {
        Task { @MainActor in
            delegate?.transcribed(.success(message))
        }
    }
    
    private func transcribe(_ error: Error) {
        Task { @MainActor in
            delegate?.transcribed(.failure(error))
        }
    }
    
    private func transcribe() {
        guard let recognizer, recognizer.isAvailable else {
            self.transcribe(SpeechRecognizerError.recognizerIsUnavailable)
            return
        }
        
        // TODO: recognizer의 locale 설정.
        // https://developer.apple.com/documentation/naturallanguage/
        // 입력된 텍스트 기반으로 언어 추정
        
        do {
            let (audioEngine, request) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            self.task = recognizer.recognitionTask(with: request, resultHandler: { [weak self] result, error in
                self?.recognitionHandler(audioEngine: audioEngine, result: result, error: error)
            })
        } catch {
            self.reset()
            self.transcribe(error)
        }
    }
    
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    nonisolated private func recognitionHandler(
        audioEngine: AVAudioEngine,
        result: SFSpeechRecognitionResult?,
        error: Error?
    ) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        }
        
        if let result {
            transcribe(result.bestTranscription.formattedString)
        }
    }
}
