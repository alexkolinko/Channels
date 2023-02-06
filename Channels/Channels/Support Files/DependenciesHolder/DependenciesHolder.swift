//
//  DependenciesHolder.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import Swinject

class DependenciesHolder {
    
    func injector() -> Container {
        let container = Container()
        
        // Register NetworkProgramsProvider. New instance created on each 'resolve()'
        container.register(NetworkProgramsProvider.self) { resolver -> NetworkProgramsProvider in
            return NetworkProgramsProvider()
        }.inObjectScope(.transient)
        
        // Register NetworkChannelsProvider. New instance created on each 'resolve()'
        container.register(NetworkChannelsProvider.self) { resolver -> NetworkChannelsProvider in
            return NetworkChannelsProvider()
        }.inObjectScope(.transient)
        
        return container
        
    }
}
