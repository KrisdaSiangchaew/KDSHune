//
//  TickerPListRepository.swift
//  KDSHune
//
//  Created by Kris on 8/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

protocol TickerRepository {
    func save(_ current: [Ticker]) throws
    func load() throws -> [Ticker]
}

class TickerPListRepository: TickerRepository {
    private var saved: [Ticker]?
    private var filename: String
    
    var url: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appending(component: "\(filename).plist")
    }
    
    init(filename: String = "my_tickers") {
        self.filename = filename
    }
    
    func save(_ current: [Ticker]) throws {
        if let saved, saved == current { return }
        let encoded = try PropertyListEncoder().encode(current)
        try encoded.write(to: url, options: [.atomic])
        self.saved = current
    }
    
    func load() throws -> [Ticker] {
        let data = try Data(contentsOf: url)
        let current = try PropertyListDecoder().decode([Ticker].self, from: data)
        self.saved = current
        return current
    }
}
