//
//  SpeechRecognizeService.swift
//  Domain
//
//  Created by Taeyoung Son on 6/10/24.
//

import Combine

public protocol SpeechRecognizeService {
    var transcript: AnyPublisher<String, Error> { get }
    func startTranscribe()
    func stopTranscribe()
}
