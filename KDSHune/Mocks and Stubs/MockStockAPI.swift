//
//  MockStockAPI.swift
//  KDSHune
//
//  Created by Kris on 3/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

#if DEBUG
struct MockStockAPI: StockAPI {
    
    var stubbedTickerSearchCallback: (() async throws -> [Ticker])!
    func tickerSearch(keywords: String) async throws -> [Ticker] {
        try await stubbedTickerSearchCallback()
    }
    
    var stubbedFetchGlobalQuoteCallback: (() async throws -> [GlobalQuote])!
    func fetchGlobalQuotes(symbols: String) async throws -> [GlobalQuote] {
        try await stubbedFetchGlobalQuoteCallback()
    }
}

#endif
