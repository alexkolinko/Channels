//
//  SplashRoute.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation

protocol SplashRoute {
    var SplashTransition: Transition { get }
    
    func showSplash()
}

extension SplashRoute where Self: RouterProtocol {
    
    func showSplash() {
        let viewController = SplashBuilder.build(injector: injector)
        open(viewController, transition: SplashTransition)
    }
}
