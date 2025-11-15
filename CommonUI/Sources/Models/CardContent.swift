//
//  CardContent.swift
//  CommonUI
//
//  Created by Taeyoung Son on 5/27/24.
//

import SwiftUI

public enum CardContent<T: CardData>: Equatable, Sendable {
    case cover(T)
    case target(T)
    case origin(T)
}
