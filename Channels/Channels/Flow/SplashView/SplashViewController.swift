//
//  SplashViewController.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import UIKit

final class SplashViewController: UIViewController, StoryboardInitializable {
    
    // - Internal properties
    var presenter: SplashPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.toggleWelcomeNavigationFlow()
    }
    
    deinit {
        print("deinit \(self)")
    }
}
