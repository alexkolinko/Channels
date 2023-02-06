//
//  StoryboardInitializable.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func board(_ board: AppStoryboards) -> Self {
        let storyboard = UIStoryboard(name: board.storyboard, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
