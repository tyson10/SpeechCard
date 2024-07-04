//
//  SpeechRecognizeService.swift
//  Domain
//
//  Created by Taeyoung Son on 6/10/24.
//

import Combine

public protocol SpeechRecognizeService {
    func startTranscribe() -> AnyPublisher<String, Error>
    func stopTranscribe()
}
