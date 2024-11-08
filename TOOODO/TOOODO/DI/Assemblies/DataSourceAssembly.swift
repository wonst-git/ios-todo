//
//  DataSourceAssembly.swift
//  TOOODO
//
//  Created by 노원진 on 11/7/24.
//

import Swinject
import Data

struct DataSourceAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(TodoLocalDataSource.self) { _ in TodoLocalDataSourceImpl() }
        container.register(CategoryLocalDataSource.self) { _ in CategoryLocalDataSourceImpl() }
    }
}
