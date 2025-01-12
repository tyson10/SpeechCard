//
//  SpeechPermissionUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 2024/07/14.
//

import Speech

import Extensions

public protocol SpeechRecognitionPermissionUseCase: Sendable {
    var isAuthorized: Bool { get }
    var request: @Sendable () async throws -> Void { get set }
}

public struct SpeechRecognitionPermissionUseCaseImpl: SpeechRecognitionPermissionUseCase {
    // TODO: AVAudioApplication, SFSpeechRecognizer을 Data Layer에서 접근하도록 수정. 해당 Data Layer의 객체는 Sendable을 준수해야 함.
    private let audioApplication: AVAudioApplication
    public var request: @Sendable () async throws -> Void
    
    public var isAuthorized: Bool {
        return SFSpeechRecognizer.authorizationStatus() == .authorized &&
        audioApplication.recordPermission == .granted
    }
    
    public init(audioSession: AVAudioApplication = .shared) {
        self.audioApplication = audioSession
        
        request = {
            guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                throw SpeechRecognizerError.notAuthorizedToRecognize
            }
            guard await AVAudioApplication.requestRecordPermission() else {
                throw SpeechRecognizerError.notPermittedToRecord
            }
        }
    }
}
