//
//  StockAPI.swift
//  KDSHune
//
//  Created by Kris on 3/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

protocol StockAPI {
    func tickerSearch(keywords: String) async throws -> [Ticker]
    func fetchGlobalQuotes(symbols: String) async throws -> [GlobalQuote]
}

extension AlphaVantageStockAPI: StockAPI {
    public func fetchGlobalQuotes(symbols: String) async throws -> [GlobalQuote] {
        let symbolsArray = symbols.components(separatedBy: ",")
        var quotes: [GlobalQuote] = []
        for symbol in symbolsArray {
            let quote = try await fetchGlobalQuote(symbol: symbol)
            quotes.append(quote)
        }
        return quotes
    }
}

class API {
    static let shared: AlphaVantageStockAPI = {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "demo"
        return AlphaVantageStockAPI(apiKey: apiKey)
    }()
}
