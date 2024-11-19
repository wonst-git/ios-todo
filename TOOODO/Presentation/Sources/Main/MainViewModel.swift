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
    @Inject private var upsertTodoUseCase: UpsertTodoUseCase
    
    @Published private(set) var categories: Array<Domain.Category> = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        getCategories()
    }
    
    private func getCategories() {
        getCategoriesUseCase.execute()
            .sink {
                switch($0) {
                case .finished:
                    print("getCategories finished")
                case .failure(let error):
                    print("getCategories error: \(error)")
                }
            } receiveValue: { [weak self] in
                print("categoreis: \($0)")
                self?.categories = $0
            }
            .store(in: &cancellables)
    }
    
    func upsertCategory(id: String?, title: String, des: String, color: Int) {
        do {
            try upsertCategoryUseCase.execute(
                Category(
                    id: id ?? "",
                    category: title,
                    categoryDes: des,
                    color: color,
                    todos: []
                )
            )
        } catch {
            print("upsertError: \(error)")
        }
    }
    
    func deleteCategory(category: Domain.Category) {
        do {
            try deleteCategoryUseCase.execute(category)
        } catch {
            print("deleteError: \(error)")
        }
    }
    
    func upsertTodo(categoryId: String, todoName: String) {
        do {
            let todo = Todo(id: "", todo: todoName, completed: false)
            
            try upsertTodoUseCase.execute(categoryId: categoryId, todo: todo)
        } catch {
            print("upsertTodoError: \(error)")
        }
    }
}
