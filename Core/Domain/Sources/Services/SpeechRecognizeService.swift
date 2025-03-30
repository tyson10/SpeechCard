//
//  SpeechRecognizeService.swift
//  Domain
//
//  Created by Taeyoung Son on 6/10/24.
//

import Foundation

public protocol SpeechRecognizeService: AnyObject, Sendable {
    @MainActor func startTranscribing(with language: Language)
    @MainActor func stopTranscribing()
    @MainActor var delegate: SpeechRecognizeServiceDelegate? { get set }
}

public protocol SpeechRecognizeServiceDelegate: Sendable, AnyObject {
    @MainActor var transcribed: (Result<String, Error>) -> Void { get set }
}
