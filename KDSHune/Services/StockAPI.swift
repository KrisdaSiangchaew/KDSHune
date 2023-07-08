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
    func fetchGlobalQuote(symbol: String) async throws -> GlobalQuote
}

extension AlphaVantageStockAPI: StockAPI {}

class API {
    static let shared: AlphaVantageStockAPI = {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "demo"
        return AlphaVantageStockAPI(apiKey: apiKey)
    }()
}
