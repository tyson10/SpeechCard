//
//  CardViewType.swift
//  Model
//
//  Created by Taeyoung Son on 2023/07/23.
//

import SwiftUI

public protocol CardViewType: View {
    var state: CardViewState { get set }
}
