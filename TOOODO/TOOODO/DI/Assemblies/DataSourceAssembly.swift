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
        container.register(LocalDataSource.self) { _ in LocalDataSourceImpl() }
    }
}
