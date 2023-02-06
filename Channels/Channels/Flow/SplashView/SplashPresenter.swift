//
//  SplashPresenter.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation

class SplashPresenter {
    
    // - Private Properties
    private var router: SplashNavigationProtocol
    private var interactor: SplashInteractorProtocol
    
    init(router: SplashNavigationProtocol, interactor: SplashInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // - Internal Naviagation
    func toggleWelcomeNavigationFlow() {
        self.router.navigateToRootView()
    }
}
