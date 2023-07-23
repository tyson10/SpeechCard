//
//  CardViewType.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/23.
//

import SwiftUI

public protocol CardViewType: View {
    var data: CardDataType { get set }
}

public protocol CardDataType {
    var bgColor: Color { get set }
    var wordPair: any WordPair { get set }
    var isFlipped: Bool { get set }
}
