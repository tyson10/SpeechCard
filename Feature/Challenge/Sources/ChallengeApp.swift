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
import Data

@main
struct ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ChallengeView<DefaultCardData>(
                store: .init(
                    initialState: .init(
                        book: BookVO(
                            contents: [
                                .init(origin: "origin", target: "target"),
                                .init(origin: "origin2", target: "target2")
                            ]
                        )
                    ),
                    reducer: ChallengeFeature.init,
                    withDependencies: {
                        $0.speechRecognitionUseCase = SpeechRecognitionUseCaseImpl(service: SpeechRecognizeServiceImpl())
                        $0.speechRecognitionPermissionUseCase = SpeechRecognitionPermissionUseCaseImpl()
                    }
                )
            )
        }
    }
}

#Preview(body: {
    ChallengeView<DefaultCardData>(
        store: .init(
            initialState: .init(
                book: BookVO(contents: [.init(origin: "안녕하세요.", target: "Hello.")])
            ),
            reducer: ChallengeFeature.init,
            withDependencies: {
                $0.speechRecognitionUseCase = SpeechRecognitionUseCaseImpl(service: SpeechRecognizeServiceImpl())
                $0.speechRecognitionPermissionUseCase = SpeechRecognitionPermissionUseCaseImpl()
            }
        )
    )
})

final class FakeSpeechRecognizeService: SpeechRecognizeService {
    func startTranscribe() {
        
    }
    
    var delegate: (any Domain.SpeechRecognizeServiceDelegate)?
    
    func stopTranscribe() { }
}
