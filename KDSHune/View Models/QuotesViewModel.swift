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
    
    func fetchQuotes(tickers: [Ticker]) async {
        guard !tickers.isEmpty else { return }
        do {
            let symbols = tickers.compactMap { $0.symbol }
            for symbol in symbols {
                let quote = try await API.shared.fetchGlobalQuote(symbol: symbol)
                guard let data = quote.data else { break }
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
