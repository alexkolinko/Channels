//
//  APIService.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import Moya


/*
 Request Enum List
 */
enum APIService {

    case getProgramItems
    case getChannelItems
}

/*
 Moya Network Layer
 If you don't now how it works -> https://github.com/Moya/Moya
 */
/*
 Uncomment default if you'll add new requests
 */
extension APIService: TargetType {
    
    var baseURL: URL {
        return .baseUrl
    }

    var path: String {
        switch self {
        case .getProgramItems:
            return "ProgramItems"
        case .getChannelItems:
            return "Channels"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getProgramItems:
            return .get
        case .getChannelItems:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getProgramItems:
            return .requestPlain
        case .getChannelItems:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        let headers = [
            "Content-type": "application/json"
        ]
        
        return headers
    }
}


