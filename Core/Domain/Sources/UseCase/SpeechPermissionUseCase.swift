//
//  SpeechPermissionUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 2024/07/14.
//

import Speech

import Extensions

public protocol SpeechPermissionUseCase {
    var isAuthorized: Bool { get }
    func request() async throws
}

public class SpeechPermissionUseCaseImpl: SpeechPermissionUseCase {
    private let audioApplication: AVAudioApplication
    
    public var isAuthorized: Bool {
        return SFSpeechRecognizer.authorizationStatus() == .authorized &&
        audioApplication.recordPermission == .granted
    }
    
    public init(audioSession: AVAudioApplication = .shared) {
        self.audioApplication = audioSession
    }
    
    public func request() async throws {
        guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
            throw SpeechRecognizerError.notAuthorizedToRecognize
        }
        guard await AVAudioApplication.requestRecordPermission() else {
            throw SpeechRecognizerError.notPermittedToRecord
        }
    }
}
