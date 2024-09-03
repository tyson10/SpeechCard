//
//  AVAudioSession+Extension.swift
//  Extensions
//
//  Created by Taeyoung Son on 6/10/24.
//

import AVFAudio

public extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
