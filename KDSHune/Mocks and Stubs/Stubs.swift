//
//  Stubs.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

#if DEBUG
extension Ticker {
    static var stubs: [Ticker] {
        [
            Ticker(symbol: "AAPL", name: "Apple, Inc."),
            Ticker(symbol: "IBM", name: "International Business Machine Corporation"),
            Ticker(symbol: "NFLX", name: "NetFlix, Inc."),
            Ticker(symbol: "AMZN", name: "Amazon.com, Inc."),
            Ticker(symbol: "AGRI", name: "AgriFORCE Growing Systems Ltd")
        ]
    }
}

extension GlobalQuoteData {
    static var stubs: [GlobalQuoteData] {
        [
            GlobalQuoteData(symbol: "AAPL", price: "193.97", change: "4.38"),
            GlobalQuoteData(symbol: "IBM", price: "133.8100", change: "-0.25"),
            GlobalQuoteData(symbol: "NFLX", price: "440.49", change: "12.250"),
            GlobalQuoteData(symbol: "AMZN", price: "130.36", change: "2.46"),
            GlobalQuoteData(symbol: "AGRI", price: "0.2267", change: "-0.0233")
        ]
    }
    
    static var stubsDict: [String : GlobalQuoteData] {
        var dict = [String : GlobalQuoteData]()
        stubs.forEach { globalQuoteData in
            dict[globalQuoteData.symbol!] = globalQuoteData
        }
        return dict
    }
}

#endif
