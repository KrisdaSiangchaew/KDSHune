//
//  TickerQuoteViewModel.swift
//  KDSHune
//
//  Created by Kris on 12/7/2566 BE.
//

import Foundation
import SwiftUI
import AlphaVantageStockAPI

class TickerGlobalQuoteViewModel: ObservableObject {
    @Published var phase: FetchPhase<GlobalQuoteData> = .initial
    var quoteData: GlobalQuoteData? { phase.value }
    var error: Error? { phase.error }
    
    let ticker: Ticker
    let stockAPI: StockAPI
    
    init(ticker: Ticker, stockAPI: StockAPI = API.shared) {
        self.ticker = ticker
        self.stockAPI = stockAPI
    }
    
    func fetchQuote() async {
        phase = .fetching
        
        do {
            guard let symbol = ticker.symbol else { return }
            let response = try await stockAPI.fetchGlobalQuotes(symbols: symbol)
            if let globalQuote = response.first, let globalQuoteData = globalQuote.data  {
                phase = .success(globalQuoteData)
            } else {
                phase = .empty
            }
        } catch {
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
