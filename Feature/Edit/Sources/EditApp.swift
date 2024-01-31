//
//  EditApp.swift
//  Edit
//
//  Created by Taeyoung Son on 1/30/24.
//

import SwiftUI

import Domain

@main
struct EditApp: App {
    var body: some Scene {
        WindowGroup {
            
        }
    }
}

class EditUseCaseStub: EditUseCase {
    func add(book: Domain.BookVO) {
        
    }
    
    func update(to book: Domain.BookVO) {
        
    }
}
