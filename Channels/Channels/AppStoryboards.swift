//
//  AppStoryboards.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation

enum AppStoryboards: String, CaseIterable {
    
    case Splash
    case Root
    
    var storyboard: String {
        return self.rawValue + "View"
    }
}
