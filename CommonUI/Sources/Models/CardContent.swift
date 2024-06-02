//
//  CardContent.swift
//  CommonUI
//
//  Created by Taeyoung Son on 5/27/24.
//

import SwiftUI

public enum CardContent<T: CardData>: Equatable {
    case target(T)
    case origin(T)
    case introduce
}
