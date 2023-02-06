//
//  SplashRouter.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import UIKit

// MARK: - SplashNavigationProtocol
protocol SplashNavigationProtocol {
    
    func navigateToRootView()
}

// MARK: - SplashRouter: Router<SplashViewController>
class SplashRouter: Router<SplashViewController>, SplashRouter.Routes {
    
    typealias Routes = RootRoute
    
    var RootViewTransition: Transition {
        return RootTransition()
    }
}

// MARK: - SplashRouter: SplashNavigationProtocol
extension SplashRouter: SplashNavigationProtocol {
    
    func navigateToRootView() {
        self.showRoot()
    }
}
