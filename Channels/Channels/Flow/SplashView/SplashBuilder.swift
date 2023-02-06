//
//  SplashBuilder.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import Swinject

class SplashBuilder {
    static func build(injector: Container) -> SplashViewController {
        let viewController = SplashViewController.board(.Splash)
        
        let router = SplashRouter(injector: injector)
        router.viewController = viewController
        
        let interactor = SplashInteractor()
        
        let presenter = SplashPresenter(router: router, interactor: interactor)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
