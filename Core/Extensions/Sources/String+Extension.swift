//
//  String+Extension.swift
//  Extensions
//
//  Created by Taeyoung Son on 12/1/24.
//

import SwiftUI

public extension String {
    var localized: LocalizedStringKey { LocalizedStringKey(self) }
}
