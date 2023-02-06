//
//  NetworkChannelsProvider.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import RxSwift
import RxCocoa

// MARK: - NetworkChannelsProviderProtocol
protocol NetworkChannelsProviderProtocol {
    
    /**
     Get actual Channels from server
     */
    func getChannels() -> Single<[Channel]>
}

// MARK: - NetworkChannelsProvider
final class NetworkChannelsProvider: NetworkProvider, NetworkChannelsProviderProtocol {
    
    func getChannels() -> RxSwift.Single<[Channel]> {
        return self.request(target: .getChannelItems)
            .flatMap { response -> Single<[Channel]> in
                return self.parse(data: response.data, for: [Channel].self)
            }
            .catch { error -> PrimitiveSequence<SingleTrait, [Channel]> in
                return Single.error(error)
            }
    }
}
