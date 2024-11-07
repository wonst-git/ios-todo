//
//  UseCaseAssembly.swift
//  TOOODO
//
//  Created by 노원진 on 11/7/24.
//

import Swinject
import Domain
import Data

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        //MARK: Category
        container.register(GetCategoriesUseCase.self) { GetCategoriesUseCaseImpl($0.resolve(CategoryRepository.self)!) }
        container.register(UpsertCategoryUseCase.self) { UpsertCategoryUseCaseImpl($0.resolve(CategoryRepository.self)!) }
        container.register(DeleteCategoryUseCase.self) { DeleteCategoryUseCaseImpl($0.resolve(CategoryRepository.self)!) }
        //MARK: Todo
        container.register(GetTodosUseCase.self) { GetTodosUseCaseImpl($0.resolve(TodoRepository.self)!) }
        container.register(UpsertTodoUseCase.self) { UpsertTodoUseCaseImpl($0.resolve(TodoRepository.self)!) }
        container.register(DeleteTodoUseCase.self) { DeleteTodoUseCaseImpl($0.resolve(TodoRepository.self)!) }
    }
}
