//
//  DependencyProviderExtension.swift
//  TOOODO
//
//  Created by 노원진 on 11/7/24.
//

import Swinject
import DIContainer

extension DependencyProvider {
    func register() {
        _ = Assembler(
            [
                DataSourceAssembly(),
                RepositoryAssembly(),
                UseCaseAssembly()
            ],
            container: self.container
        )
    }
}
