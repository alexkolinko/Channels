//
//  NetworkProvider.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import Moya
import RxMoya
import RxSwift

class NetworkProvider {
    
    // - Private Properties
    private var provider: MoyaProvider<APIService>
    
    init() {
        self.provider = MoyaProvider<APIService>(plugins: [])
    }
    
    // - Internal
    func request(target: APIService) -> Single<Response> {
        return privateRequest(target: target)
            .flatMap { response -> Single<Response> in
                guard response.statusCode == 401 || response.statusCode == 403 else {
                    return Single.just(response)
                }
                return Single.never()
            }
            .catch { error -> PrimitiveSequence<SingleTrait, Response> in
                return .error(error)
            }
    }
    
    func parse<T: Decodable >(data: Data, for type: T.Type) -> Single<T> {
        do {
            let response: T = try JSONDecoder().decode(type.self, from: data)
            return Single.just(response)
        } catch {
            return Single.error(error)
        }
    }
    
    // - Private
    private func privateRequest(target: APIService) -> Single<Response> {
        return provider.rx.request(target)
    }
}
