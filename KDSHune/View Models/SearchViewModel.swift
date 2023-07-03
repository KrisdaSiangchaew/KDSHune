//
//  SearchViewModel.swift
//  KDSHune
//
//  Created by Kris on 3/7/2566 BE.
//

import Combine
import Foundation
import SwiftUI
import AlphaVantageStockAPI

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var phase: FetchPhase<[Ticker]> = .initial
    
    private var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var tickers: [Ticker] { phase.value ?? [] }
    var error: Error? { phase.error }
    var isSearching: Bool { !trimmedQuery.isEmpty }
    
    var emptyListText: String {
        "Symbols not found for \n\"\(query)\""
    }
    
    private let stockAPI: StockAPI
    
    init(query: String = "") {
        #warning("check how to install api key")
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "demo"
        self.stockAPI = AlphaVantageStockAPI(apiKey: apiKey)
        self.query = query
    }
}
