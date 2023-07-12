//
//  QuotesDataViewmodel.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation
import SwiftUI
import AlphaVantageStockAPI

@MainActor
class QuotesViewModel: ObservableObject {
    @Published var quoteDict: [String : GlobalQuoteData] = [:]
    private let stockAPI: StockAPI
    
    init(stockAPI: StockAPI = API.shared) {
        self.stockAPI = stockAPI
    }
    
    func fetchQuotes(tickers: [Ticker]) async {
        guard !tickers.isEmpty else { return }
        do {
            let symbols = tickers.compactMap { $0.symbol }.joined(separator: ",")
            
            let quotes = try await stockAPI.fetchGlobalQuotes(symbols: symbols)
            
            for quote in quotes {
                guard let data = quote.data, let symbol = data.symbol else { break }
                self.quoteDict[symbol] = data
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func priceForTicker(_ ticker: Ticker) -> PriceChange? {
        guard let symbol = ticker.symbol,
              let quote = quoteDict[symbol],
              let price = quote.priceText,
              let change = quote.diffText else { return nil }
        return (price, change)
              
    }
}
