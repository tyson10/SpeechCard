//
//  CardContent.swift
//  CommonUI
//
//  Created by Taeyoung Son on 5/4/24.
//

import SwiftUI

public protocol CardContent: Equatable {
    var word: String { get }
    var color: Color { get }
}

public struct DefaultCardContent: CardContent {
    public let word: String
    public let color: Color
}
