//
//  RateLimiter.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

actor RateLimiter {
    private let requestsPerMinute: Int
    private var timestamps: [Date]
    
    init(requestsPerMinute: Int) {
        self.requestsPerMinute = requestsPerMinute
        self.timestamps = []
    }
    
    func shouldAllowRequest() -> Bool {
        let now = Date()
        let oneMinuteAgo = now.addingTimeInterval(-60)
        
        timestamps = timestamps.filter { $0 > oneMinuteAgo }
        
        guard timestamps.count < requestsPerMinute else {
            return false
        }
        
        timestamps.append(now)
        return true
    }
    
    func timeUntilNextAllowedRequest() -> TimeInterval? {
        guard !timestamps.isEmpty else { return nil }
        
        let now = Date()
        let oneMinuteAgo = now.addingTimeInterval(-60)
        
        timestamps = timestamps.filter { $0 > oneMinuteAgo }
        
        guard timestamps.count >= requestsPerMinute,
              let oldestTimestamp = timestamps.first else {
            return nil
        }
        
        return oldestTimestamp.addingTimeInterval(60).timeIntervalSince(now)
    }
}
