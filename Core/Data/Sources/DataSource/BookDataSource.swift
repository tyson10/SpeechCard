//
//  ShelfDataSource.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Foundation

import SwiftData

import Domain

public protocol BookDataSource {
    func fetchAllBooks() throws -> [BookDTO]
    func fetchBook(withName name: String) throws -> BookDTO?
    func insert(book: BookDTO) throws
    func deleteBook(name: String) throws
    func update(to book: BookDTO) throws
}

public class BookLocalDataSource: BookDataSource {
    private let modelContext: ModelContext
    
    public init() throws {
        let container = try ModelContainer(for: BookDTO.self)
        modelContext = ModelContext(container)
    }
    
    public func fetchAllBooks() throws -> [BookDTO] {
        return try modelContext.fetch(.init())
    }
    
    public func fetchBook(withName name: String) throws -> BookDTO? {
        // Predicate 매크로의 body에서 다른 함수를 호출할 수 없음. static 함수는 호출 가능.
        let predicate = #Predicate<BookDTO> { $0.name == name }
        let descriptor = FetchDescriptor(predicate: predicate)
        return try modelContext.fetch(descriptor).first
    }
    
    public func insert(book: BookDTO) throws {
        if book.name.isEmpty {
            throw BookDataSourceError.emptyName
        } else if book.contents.isEmpty {
            throw BookDataSourceError.emptyContents
        } else if try fetchBook(withName: book.name) != nil {
            throw BookDataSourceError.duplicated
        } else {
            modelContext.insert(book)
            try modelContext.save()
        }
    }
    
    public func deleteBook(name: String) throws {
        let predicate = #Predicate<BookDTO> { $0.name == name }
        try modelContext.delete(
            model: BookDTO.self,
            where: predicate
        )
        try modelContext.save()
    }
    
    public func update(to book: BookDTO) throws {
        let bookName = book.name
        let predicate = #Predicate<BookDTO> { $0.name == bookName }
        let descriptor = FetchDescriptor<BookDTO>(predicate: predicate)
        
        if var old = try modelContext.fetch(descriptor).first {
            update(book: &old, with: book)
        }
    }
    
    private func update(book: inout BookDTO, with new: BookDTO) {
        book.name = new.name
        book.targetLangCode = new.targetLangCode
        book.originLangCode = new.originLangCode
        book.contents = new.contents
    }
}
