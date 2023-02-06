//
//  ChannelSectionModel.swift
//  Channels
//
//  Created by kolinko oleksandr on 06.02.2023.
//

import Foundation

// MARK: - RootPresenter + ChannelSectionModel
extension RootPresenter {
    
    struct ChannelSectionModel: Hashable {
        var id: Int
        var title: String
        var programs: [Program]
        
        init(id: Int, title: String, programs: [Program]) {
            self.id = id
            self.title = title
            self.programs = programs
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: ChannelSectionModel, rhs: ChannelSectionModel) -> Bool {
            lhs.id == rhs.id
        }
    }
}
