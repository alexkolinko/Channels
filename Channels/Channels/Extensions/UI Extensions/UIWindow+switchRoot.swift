//
//  UIWindow+switchRoot.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import UIKit

extension UIWindow {
    
    func switchRootViewController(_ viewController: UIViewController, animated: Bool = true, duration: TimeInterval = 0.35, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { [weak self] _ in
            completion?()
            self?.rootViewController?.setNeedsStatusBarAppearanceUpdate()
        })
    }
}
