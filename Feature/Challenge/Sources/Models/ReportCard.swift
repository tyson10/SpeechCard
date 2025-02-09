//
//  ReportCard.swift
//  Challenge
//
//  Created by Taeyoung Son on 2/9/25.
//

import Foundation

public struct ReportCard: Equatable {
    public let timestamp: Date
    public private(set) var sessions: [Session]
    
    public init(
        timestamp: Date = Date(),
        sessions: [Session] = []
    ) {
        self.timestamp = timestamp
        self.sessions = sessions
    }
    
    public mutating func append(new record: Session) {
        sessions.append(record)
    }
}

public extension ReportCard {
    struct Session: Equatable {
        let question: String
        let correctAnswer: String
        let userAnswer: String
    }
}

public extension ReportCard.Session {
    var isCorrectAnswer: Bool {
        return correctAnswer.lowercased() == userAnswer.lowercased()
    }
}
