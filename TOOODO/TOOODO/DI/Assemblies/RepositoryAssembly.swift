//
//  RepositoryAssembly.swift
//  TOOODO
//
//  Created by 노원진 on 11/7/24.
//

import Data
import Domain
import Swinject

struct RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CategoryRepository.self) { CategoryRepositoryImpl(localDataSource: $0.resolve(CategoryLocalDataSource.self)!)}
        container.register(TodoRepository.self) { TodoRepositoryImpl(localDataSource: $0.resolve(TodoLocalDataSource.self)!)}
    }
}
