//
//  NetworkProgramsProvider.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import RxSwift
import RxCocoa

// MARK: - NetworkProgramsProviderProtocol
protocol NetworkProgramsProviderProtocol {
    
    /**
     Get actual Programs from server
     */
    func getPrograms() -> Single<[Program]>
}

// MARK: - NetworkProgramsProvider
final class NetworkProgramsProvider: NetworkProvider, NetworkProgramsProviderProtocol {
    
    func getPrograms() -> Single<[Program]> {
        return self.request(target: .getProgramItems)
            .flatMap { response -> Single<[Program]> in
                return self.parse(data: response.data, for: [Program].self)
            }
            .catch { error -> PrimitiveSequence<SingleTrait, [Program]> in
                return Single.error(error)
            }
    }
}
