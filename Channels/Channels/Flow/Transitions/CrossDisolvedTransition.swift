//
//  CrossDisolvedTransition.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import UIKit

class CrossDisolvedTransition: NSObject {
    
    var animator: AnimatorProtocol?
    var isAnimated: Bool = true
    
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle
    
    var completionHandler: (() -> Void)?
    
    weak var viewController: UIViewController?
    
    init(animator: AnimatorProtocol? = nil,
         isAnimated: Bool = true,
         modalTransitionStyle: UIModalTransitionStyle = .crossDissolve,
         modalPresentationStyle: UIModalPresentationStyle = .overCurrentContext) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

extension CrossDisolvedTransition: Transition {
    func open(_ viewController: UIViewController) {
        viewController.transitioningDelegate = self
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        
        self.viewController?.present(viewController, animated: isAnimated, completion: completionHandler)
    }
    
    func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: isAnimated, completion: completionHandler)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension CrossDisolvedTransition: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        return animator
    }
}
