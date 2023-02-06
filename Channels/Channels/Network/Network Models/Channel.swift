//
//  Channel.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation

struct Channel: Decodable, Hashable {
    let orderNum: Int
    let accessNum: Int
    let CallSign: String
    let id: Int
}
