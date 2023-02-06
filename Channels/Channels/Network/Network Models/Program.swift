//
//  Program.swift
//  Channels
//
//  Created by kolinko oleksandr on 05.02.2023.
//

import Foundation

struct Program: Decodable, Hashable {
    let startTime: String
    let recentAirTime: RecentAirTime
    let length: Int
    let name: String
    
    init(startTime: String, recentAirTime: RecentAirTime, length: Int, name: String) {
        self.startTime = startTime
        self.recentAirTime = recentAirTime
        self.length = length
        self.name = name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(recentAirTime.id)
    }
    
    static func == (lhs: Program, rhs: Program) -> Bool {
        lhs.recentAirTime.id == rhs.recentAirTime.id
    }
}

// MARK: - Program + getDate
extension Program {
    
    func getDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy || HH:mm"
        
        let dateObj: Date? = dateFormatterGet.date(from: self.startTime)
        
        return dateFormatter.string(from: dateObj!)
    }
}
