//
//  CardContent.swift
//  CommonUI
//
//  Created by Taeyoung Son on 5/4/24.
//

import SwiftUI

public protocol CardData: Equatable {
    var word: String { get }
    var color: Color { get }
    var countDown: Int { get }
}

public struct DefaultCardData: CardData {
    public let word: String
    public let color: Color
    public let countDown: Int
}
