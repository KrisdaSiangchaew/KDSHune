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
    
    func priceForTicker(_ ticker: Ticker) -> PriceChange? {
        guard let symbol = ticker.symbol,
              let quote = quoteDict[symbol],
              let price = quote.priceText,
              let change = quote.diffText else { return nil }
        return (price, change)
              
    }
}
