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
    
    private var cancellable = Set<AnyCancellable>()
    
    init(query: String = "") {
        #warning("check how to install api key")
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? "demo"
        self.stockAPI = AlphaVantageStockAPI(apiKey: apiKey)
        self.query = query
        
        startObserving()
    }
    
    private func startObserving() {
        $query
            .debounce(for: 0.25, scheduler: DispatchQueue.main)
            .sink { _ in
                Task { [weak self] in await self?.searchTickers() }
            }
            .store(in: &cancellable)
        
        $query
            .filter { $0.isEmpty }
            .sink { [weak self] _ in self?.phase = .initial }
            .store(in: &cancellable)
    }
    
    func searchTickers() async {
        let searchQuery = trimmedQuery
        guard !searchQuery.isEmpty else { return }
        phase = .fetching
        
        do {
            let tickers = try await stockAPI.tickerSearch(keywords: searchQuery)
            guard trimmedQuery == searchQuery else { return }
            if tickers.isEmpty {
                phase = .empty
            } else {
                phase = .success(tickers)
            }
        } catch {
            if searchQuery != searchQuery { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
