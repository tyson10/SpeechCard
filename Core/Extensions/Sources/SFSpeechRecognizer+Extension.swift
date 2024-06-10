//
//  SFSpeechRecognizer+Extension.swift
//  Extensions
//
//  Created by Taeyoung Son on 6/10/24.
//

import Speech

public extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}
