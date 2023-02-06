//
//  RootRouter.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import UIKit

// MARK: - RootNavigationProtocol
protocol RootNavigationProtocol {}

// MARK: - RootRouter: Router<RootViewController>
class RootRouter: Router<RootViewController> {}

// MARK: - RootRouter: RootNavigationProtocol
extension RootRouter: RootNavigationProtocol {}
