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
    @Published var tickers: [Ticker] = []
    
    var emptyTickerText: String = "Search & add symbol to see stock quotes"
    
    var titleText: String = "KDS Hune"
    
    @Published var subtitleText: String = ""
    
    private let subtitleDateFormatter: DateFormatter = {
       let df = DateFormatter()
        df.dateFormat = "MM-dd"
        return df
    }()
    
    init() {
        self.subtitleText = subtitleDateFormatter.string(from: Date())
    }
    
    func removeTickers(atOffsets offsets: IndexSet) {
        tickers.remove(atOffsets: offsets)
    }
    
}
