//
//  MainViewModel.swift
//  Presentation
//
//  Created by 노원진 on 11/11/24.
//

import Foundation
import Swinject
import Domain
import DIContainer
import Combine

class MainViewModel: ObservableObject {
    @Inject private var getCategoriesUseCase: GetCategoriesUseCase
    @Inject private var upsertCategoryUseCase: UpsertCategoryUseCase
    @Inject private var deleteCategoryUseCase: DeleteCategoryUseCase
    
    @Published var categories: Array<Domain.Category> = []
    
    init() {
        getCategories()
    }
    
    func upsertCategoryTest() {
        do {
            try upsertCategoryUseCase.execute(
                Category(
                    id: "",
                    category: "Category\(categories.count) This is category This is category This is category",
                    categoryDes: "This is category\(categories.count)",
                    color: (0xaa000000...0xffffffff).randomElement()!,
                    todos: [
                        Todo(id: "", todo: "Todo1", completed: Bool.random()),
                        Todo(id: "", todo: "Todo2", completed: Bool.random()),
                        Todo(id: "", todo: "Todo3", completed: Bool.random()),
                        Todo(id: "", todo: "Todo4", completed: Bool.random()),
                        Todo(id: "", todo: "Todo5", completed: Bool.random()),
                    ]
                )
            )
        } catch {
            print("upsertError: \(error)")
        }
        
        getCategories()
    }
    
    func deleteCategoryTest() {
        do {
            try categories.forEach { category in
                try deleteCategoryUseCase.execute(category.id)
            }
        } catch {
            print("deleteError: \(error)")
        }
        
        getCategories()
    }
    
    func getCategories() {
        categories = getCategoriesUseCase.execute()
    }
}
