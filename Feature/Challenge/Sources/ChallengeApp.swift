//
//  ChallengeApp.swift
//  Challenge
//
//  Created by Taeyoung Son on 4/29/24.
//

import SwiftUI

import Domain
import CommonUI
import Combine

@main
struct ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ChallengeView<DefaultCardData>(
                store: .init(
                    initialState: .init(
                        book: BookVO(contents: [.init(origin: "origin", target: "target")])
                    ),
                    reducer: { 
                        ChallengeFeature(
                            speechRecognitionUseCase: SpeechRecognitionUseCaseImpl(
                                service: FakeSpeechRecognizeService()
                            )
                        )
                    }
                )
            )
        }
    }
}

fileprivate class FakeSpeechRecognizeService: SpeechRecognizeService {
    var transcript: AnyPublisher<String, Error> = PassthroughSubject().eraseToAnyPublisher()
    
    func startTranscribe() { }
    func stopTranscribe() { }
}
