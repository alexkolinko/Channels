//
//  InjectorProtocol.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Swinject

protocol InjectorProtocol {
    var injector: Container { get set }
}
