//
//  CardContent.swift
//  CommonUI
//
//  Created by Taeyoung Son on 5/27/24.
//

import SwiftUI

public enum CardContent<T: CardData>: Equatable, Sendable {
    case target(T)
    case origin(T)
    // TODO: introduce 삭제. introduce는 외부(부모 레벨)에서 관리
    case introduce
}
