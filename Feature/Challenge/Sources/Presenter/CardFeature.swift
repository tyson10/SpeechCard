//
//  CardFeature.swift
//  Challenge
//
//  Created by Taeyoung Son on 10/3/24.
//

import ComposableArchitecture

import Domain
import CommonUI
import AppDependencies

// TODO: 음성인식, 채점까지 다 되도록 구현. ChallengeFeature 기능에서 기능을 뺏어와야 함. ChallengeFeature의 Child로 구현.
@Reducer
struct CardFeature<T: CardData> {
    @Dependency(\.continuousClock) private var clock
    @Dependency(\.speechRecognitionUseCase) private var speechRecognitionUseCase: SpeechRecognitionUseCase
    @Dependency(\.speechRecognitionPermissionUseCase) private var speechRecognitionPermissionUseCase: SpeechRecognitionPermissionUseCase
    
    @ObservableState
    struct State: Equatable {
        var wordPair: DefaultWordPair
        var remainedSeconds: Int?
        var content: CardContent<T>
        
        var transcript: String = ""
        
        init(wordPair: DefaultWordPair) {
            self.wordPair = wordPair
            self.content = .target(
                T(
                    word: wordPair.target,
                    color: .white,
                    countDown: 7
                )
            )
        }
    }
    
    @CasePathable
    enum Action {
        
    }
}

/// 문제 풀 떄 카드에 보여져야 할 항목
/// 1. 단어(target)
/// 2. 잔여 시간
/// 3. 음성 인식으로 인식된 텍스트(실시간으로 업데이트)
///
/// 문제 푼 후 카드에 보여져야 할 항목
/// 1. 단어(origin)
/// 2. 음성인식 텍스트
/// 2. 맞았는지 틀렸는지
///
/// 결국 뭐가 필요하냐
/// 1. 단어(target/origin)
/// 2. 잔여시간
/// 3. 음성인식 텍스트
/// 4. 맞았는지 틀렸는지
