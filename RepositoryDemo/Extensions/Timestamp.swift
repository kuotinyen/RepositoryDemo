//
//  ExpiredJobCheck.swift
//  RepositoryDemo
//
//  Created by TING YEN KUO on 2019/1/28.
//  Copyright © 2019 TING YEN KUO. All rights reserved.
//

import Foundation

typealias Timestamp = Int

extension Timestamp {
    
    func isExpired() -> Bool {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        print("last fetch date: \(dformatter.string(from: date))")
        
        let timeIntervalSinceNow = date.timeIntervalSinceNow
        let secondsLimit = 60 // minute
        return Int(-timeIntervalSinceNow) > secondsLimit
    }
    
    static func current() -> Timestamp {
        let now = Date()
        let timeInterval = now.timeIntervalSince1970
        return Timestamp(timeInterval)
    }
}

