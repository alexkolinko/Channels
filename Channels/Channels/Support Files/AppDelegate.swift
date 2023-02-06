//
//  AppDelegate.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // - Internal Properties
    var window: UIWindow?
    
    // - Private Service Properties
    private let dependencies = Dependecies()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        self.windowConfig(injector: dependencies.injector)
        
        return true
    }

}

// MARK: - private extension AppDelegate
private extension AppDelegate {
    
    func windowConfig(injector: Container) {
        window?.rootViewController = SplashBuilder.build(injector: injector)
        window?.makeKeyAndVisible()
    }
}

// MAKR: - AppDelegate + Dependecies
private extension AppDelegate {
    
    struct Dependecies {
        
        let injector: Container
        
        // - Private Dependencies Services
        private var dependenciesHolder: DependenciesHolder!
        
        init() {
            self.dependenciesHolder = DependenciesHolder()
            self.injector = dependenciesHolder.injector()
        }
    }
}


