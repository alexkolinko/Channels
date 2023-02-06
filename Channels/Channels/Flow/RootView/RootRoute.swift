//
//  RootRoute.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation

protocol RootRoute {
    var RootViewTransition: Transition { get }
    
    func showRoot()
}

extension RootRoute where Self: RouterProtocol {
    
    func showRoot() {
        let viewController = RootBuilder.build(injector: injector)
        open(viewController, transition: RootViewTransition)
    }
}
