//
//  RootInteractor.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import RxCocoa
import RxSwift

// MARK: - RootInteractorProtocol
protocol RootInteractorProtocol {
    
    /// Data source with posts
    var programs: BehaviorRelay<[Program]> { get }
    
    /// Data source with posts
    var channels: BehaviorRelay<[Channel]> { get }
}

// MARK: - RootInteractor
class RootInteractor {
    
    // - Internal Properties
    let programs = BehaviorRelay<[Program]>(value: [])
    let channels = BehaviorRelay<[Channel]>(value: [])
    
    // - Private Properties
    private var disposeBag = DisposeBag()
    private var networkProgramsProvider: NetworkProgramsProviderProtocol
    private var networkChannelsProvider: NetworkChannelsProviderProtocol
    
    init(
        networkProgramsProvider: NetworkProgramsProviderProtocol,
        networkChannelsProvider: NetworkChannelsProviderProtocol
    ) {
        self.networkProgramsProvider = networkProgramsProvider
        self.networkChannelsProvider = networkChannelsProvider
        self.binding()
    }
}

// MARK: - RootInteractor + Private
private extension RootInteractor {
    
    func binding() {
        self.networkProgramsProvider.getPrograms()
            .subscribe(
                onSuccess: { [weak self] response in
                    self?.programs.accept(response)
                },
                onFailure: { error in
                    print("\(error)")
                }
            )
            .disposed(by: self.disposeBag)
        
        self.networkChannelsProvider.getChannels()
            .subscribe(
                onSuccess: { [weak self] response in
                    self?.channels.accept(response)
                },
                onFailure: { error in
                    print("\(error)")
                }
            )
            .disposed(by: self.disposeBag)
    }
}

// MARK: - RootInteractor: RootInteractorProtocol
extension RootInteractor: RootInteractorProtocol {}
