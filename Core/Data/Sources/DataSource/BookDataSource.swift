//
//  ShelfDataSource.swift
//  Data
//
//  Created by Taeyoung Son on 1/5/24.
//

import Foundation
import SwiftData

public protocol BookDataSource {
    func fetchAllBooks() throws -> [BookDTO]
    func insert(book: BookDTO) throws
    func delete(book: BookDTO) throws
    func update(to book: BookDTO) throws
}

public class BookLocalDataSource: BookDataSource {
    private let modelContext: ModelContext
    
    init() throws {
        let container = try ModelContainer(for: BookDTO.self)
        modelContext = ModelContext(container)
    }
    
    public func fetchAllBooks() throws -> [BookDTO] {
        return try modelContext.fetch(.init())
    }
    
    public func insert(book: BookDTO) throws {
        modelContext.insert(book)
        try modelContext.save()
    }
    
    public func delete(book: BookDTO) throws {
        modelContext.delete(book)
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
