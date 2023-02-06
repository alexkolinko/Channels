//
//  RootPresenter.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - RootPresenter
final class RootPresenter {
    
    let viewContent = BehaviorRelay<[ChannelSectionModel]>(value: [])
    
    // - Private Properties
    private var programs = BehaviorRelay<[Program]>(value: [])
    private var channels = BehaviorRelay<[Channel]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let router: RootNavigationProtocol
    private let interactor: RootInteractorProtocol
    
    init(router: RootNavigationProtocol, interactor: RootInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        self.binding()
    }
}

// MARK: - RootPresenter + Private
private extension RootPresenter {
    
    func binding() {
        
        self.interactor.channels
            .bind(to: self.channels)
            .disposed(by: self.disposeBag)
        
        self.interactor.programs
            .bind(to: self.programs)
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(self.channels, self.programs)
            .flatMap { [weak self] channels, programs -> Observable<[ChannelSectionModel]> in
               
                let sections = channels.map { channel in
                    let programs = self?.getPrograms(channelID: channel.id, programs: programs)
                    return ChannelSectionModel(id: channel.id, title: channel.CallSign, programs: programs ?? [])
                }
                return Observable.of(sections)
            }
            .subscribe(onNext: { [weak self] channels in
                self?.viewContent.accept(channels)
            })
            .disposed(by: self.disposeBag)
    }
    
    func getPrograms(channelID: Int, programs: [Program]) -> [Program] {
        var items = [Program]()
        for item in programs {
            if channelID == item.recentAirTime.channelID {
                items.append(item)
            }
        }
        return items
    }
    
}
