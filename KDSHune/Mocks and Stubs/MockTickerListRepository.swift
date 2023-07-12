//
//  MockTickerListRepository.swift
//  KDSHune
//
//  Created by Kris on 8/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

#if DEBUG
struct MockTickerListRepository: TickerRepository {
    
    var stubbedLoad: (() throws -> [Ticker])!
    
    func save(_ current: [Ticker]) throws {
        
    }
    
    func load() throws -> [Ticker] {
        try stubbedLoad()
    }
}
#endif
