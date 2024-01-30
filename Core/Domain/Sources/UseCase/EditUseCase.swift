//
//  EditUseCase.swift
//  Domain
//
//  Created by Taeyoung Son on 1/30/24.
//

public protocol EditUseCase {
    func add(book: BookVO)
    func update(to book: BookVO)
}

//public class EditUseCaseImpl: EditUseCase {
//    
//}
