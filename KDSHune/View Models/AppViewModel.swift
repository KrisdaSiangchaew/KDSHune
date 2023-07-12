//
//  AppViewModel.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation
import SwiftUI
import AlphaVantageStockAPI

@MainActor
class AppViewModel: ObservableObject {
    @Published var tickers: [Ticker] = [] {
        didSet {
            saveTickers()
        }
    }
    
    var emptyTickerText: String = "Search & add symbol to see stock quotes"
    
    var titleText: String = "KDS Hune"
    
    @Published var subtitleText: String = ""
    
    private let subtitleDateFormatter: DateFormatter = {
       let df = DateFormatter()
        df.dateFormat = "MM-dd"
        return df
    }()
    
    private var tickerRepository: TickerRepository
    
    init(repository: TickerRepository = TickerPListRepository()) {
        self.tickerRepository = repository
        self.subtitleText = subtitleDateFormatter.string(from: Date())
        loadTickers()
    }
    
    private func loadTickers() {
        do {
            let current = try self.tickerRepository.load()
            self.tickers = current
        } catch {
            print(error.localizedDescription)
            self.tickers = []
        }
    }
    
    private func saveTickers() {
        do {
            try self.tickerRepository.save(self.tickers)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var openAttributeLink: some View {
        Link("Powered by AlphaVantage Stock Market API", destination: URL(string: "https://www.alphavantage.co/")!)
            .foregroundColor(Color(uiColor: .secondaryLabel))
    }
    
    func removeTickers(atOffsets offsets: IndexSet) {
        tickers.remove(atOffsets: offsets)
    }
    
    func isAddedToMyTickers(ticker: Ticker) -> Bool {
        tickers.first { $0.symbol == ticker.symbol } != nil
    }
    
    func toggleTicker(_ ticker: Ticker) {
        if isAddedToMyTickers(ticker: ticker) {
            removeFromMyTickers(ticker: ticker)
        } else {
            addToMyTickers(ticker: ticker)
        }
    }
    
    private func addToMyTickers(ticker: Ticker) {
        tickers.append(ticker)
    }
    
    private func removeFromMyTickers(ticker: Ticker) {
        guard let index = tickers.firstIndex(where: { $0.symbol == ticker.symbol }) else { return }
        tickers.remove(at: index)
    }
}
