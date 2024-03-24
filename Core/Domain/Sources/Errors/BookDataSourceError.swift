//
//  BookDataSourceError.swift
//  Domain
//
//  Created by Taeyoung Son on 3/24/24.
//

public enum BookDataSourceError: Error {
    case duplicated
    case emptyName
    case emptyContents
}
