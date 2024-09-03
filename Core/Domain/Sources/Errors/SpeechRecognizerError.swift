//
//  SpeechRecognizerError.swift
//  Domain
//
//  Created by Taeyoung Son on 2024/07/14.
//

public enum SpeechRecognizerError: Error {
    case nilRecognizer
    case notAuthorizedToRecognize
    case notPermittedToRecord
    case recognizerIsUnavailable
}
