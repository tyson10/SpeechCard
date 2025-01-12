//
//  Array+Extension.swift
//  Extensions
//
//  Created by Taeyoung Son on 1/4/25.
//

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
