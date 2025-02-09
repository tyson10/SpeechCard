//
//  ReportCardView.swift
//  Challenge
//
//  Created by Taeyoung Son on 2/9/25.
//

import SwiftUI

import Extensions

import ComposableArchitecture

public struct ReportCardView: View {
    @State private var store: StoreOf<ReportCardFeature>
    
    public init() {
        self.store = StoreOf<ReportCardFeature>(
            initialState: .init(reportCard: .init()),
            reducer: {
                ReportCardFeature()
            }
        )
    }
    
    public init(store: StoreOf<ReportCardFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(store.reportCard.sessions) { session in
                        ItemView(session: session)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.bottom, 70)
            }
            .navigationTitle("report_card".localized)
            
            VStack {
                Spacer()
                Button(action: {
                    store.send(.endChallengeButtonTapped)
                }) {
                    Text("end_challenge".localized)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.mint)
                        .cornerRadius(25)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

// MARK: - SubViews
private extension ReportCardView {
    struct ItemView: View {
        @State private var session: ReportCard.Session
        
        init(session: ReportCard.Session) {
            self.session = session
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(session.question)
                    .font(.headline)
                
                Text("Your Answer: \(session.userAnswer)")
                    .foregroundColor(session.isCorrectAnswer ? .green : .red)
                    .font(.subheadline)
                
                Text(session.isCorrectAnswer ? "Correct ✅" : "Incorrect ❌")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(session.isCorrectAnswer ? .green : .red)
            }
            .padding()
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        session.isCorrectAnswer ?
                        Color.green.opacity(0.1) : .red.opacity(0.1)
                    )
            )
        }
    }
}

// MARK: - Preview
#Preview {
    ReportCardView(
        store: StoreOf<ReportCardFeature>(
            initialState: .init(
                reportCard: .init(
                    sessions: [
                        ReportCard.Session(
                            question: "한 겨울에도 아이스 아메리카노를 먹는 당신은 캡틴 아메리카노.",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        ),
                        ReportCard.Session(
                            question: "아아",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAhAhAhAhAhAhAhAhAhAhAhAhAhAhAhAhAhAhAhAhAh"
                        ),
                        ReportCard.Session(
                            question: "아아",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        ),
                        ReportCard.Session(
                            question: "아아",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        ),
                        ReportCard.Session(
                            question: "아아",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        ),
                        ReportCard.Session(
                            question: "한 겨울에도 아이스 아메리카노를 먹는 당신은 캡틴 아메리카노.",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        ),
                        ReportCard.Session(
                            question: "한 겨울에도 아이스 아메리카노를 먹는 당신은 캡틴 아메리카노.",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        ),
                        ReportCard.Session(
                            question: "한 겨울에도 아이스 아메리카노를 먹는 당신은 캡틴 아메리카노.",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        ),
                        ReportCard.Session(
                            question: "한 겨울에도 아이스 아메리카노를 먹는 당신은 캡틴 아메리카노.",
                            correctAnswer: "AhAh",
                            userAnswer: "AhAh"
                        )
                    ]
                )
            ),
            reducer: {
                ReportCardFeature()
            }
        )
    )
}
