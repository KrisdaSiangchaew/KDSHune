//
//  TickerQuoteViewModel.swift
//  KDSHune
//
//  Created by Kris on 12/7/2566 BE.
//

import Foundation
import SwiftUI
import AlphaVantageStockAPI

class TickerQuoteViewModel: ObservableObject {
    @Published var phase: FetchPhase<Quote> = .initial
    var quote: Quote? { phase.value }
    var error: Error? { phase.error }
    
    private let ticker: Ticker
    private let stockAPI: StockAPI
    
    init(ticker: Ticker, stockAPI: StockAPI = API.shared) {
        self.ticker = ticker
        self.stockAPI = stockAPI
    }
}
