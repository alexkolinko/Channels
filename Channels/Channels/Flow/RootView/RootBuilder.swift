//
//  RootBuilder.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import UIKit
import Swinject

// MARK: - RootBuilder
class RootBuilder {
    
    static func build(injector: Container) -> RootViewController {
        let viewController = RootViewController.board(.Root)

        let router = RootRouter(injector: injector)
        router.viewController = viewController

        let interactor = RootInteractor(
            networkProgramsProvider: injector.resolve(NetworkProgramsProvider.self)!,
            networkChannelsProvider: injector.resolve(NetworkChannelsProvider.self)!
        )
        
        let presenter = RootPresenter(router: router, interactor: interactor)

        viewController.presenter = presenter
        
        return viewController
    }
    
    
}
