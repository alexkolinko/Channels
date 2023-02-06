//
//  AnimatorProtocol.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import UIKit

protocol AnimatorProtocol: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
