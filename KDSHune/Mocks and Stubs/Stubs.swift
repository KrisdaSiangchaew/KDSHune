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
            Ticker(symbol: "AGRI", name: "AgriFORCE Growing Systems Ltd"),
            Ticker(
                symbol: "600104.SHH",
                name: "SAIC Motor Corporation Ltd",
                type: "Equity",
                region: "Shanghai",
                marketOpen: "09:30",
                marketClose: "15:00",
                timeZone: "UTC+08",
                currency: "CNY",
                matchScore: "0.2667",
                errorMessage: nil,
                information: nil)
        ]
    }
    
    static var stub: Ticker {
        Ticker(
            symbol: "600104.SHH",
            name: "SAIC Motor Corporation Ltd",
            type: "Equity",
            region: "Shanghai",
            marketOpen: "09:30",
            marketClose: "15:00",
            timeZone: "UTC+08",
            currency: "CNY",
            matchScore: "0.2667",
            errorMessage: nil,
            information: nil)
    }
}

extension GlobalQuote {
    static var stubs: [GlobalQuote] {
        let globalQuotes = GlobalQuoteData.stubs.map { GlobalQuote(data: $0, error: nil) }
        return globalQuotes
    }
    
    static var stub: GlobalQuote {
        let globalQuote = GlobalQuote(data: GlobalQuoteData.stub, error: nil)
        return globalQuote
    }
}

extension GlobalQuoteData {
    static var stubs: [GlobalQuoteData] {
        [
            GlobalQuoteData(symbol: "AAPL", price: "193.97", change: "4.38"),
            GlobalQuoteData(symbol: "IBM", price: "133.8100", change: "-0.25"),
            GlobalQuoteData(symbol: "NFLX", price: "440.49", change: "12.250"),
            GlobalQuoteData(symbol: "AMZN", price: "130.36", change: "2.46"),
            GlobalQuoteData(symbol: "AGRI", price: "0.2267", change: "-0.0233"),
            GlobalQuoteData(
                symbol: "600104.SHH",
                open: "14.3300",
                high: "14.6000",
                low: "14.3200",
                price: "14.5400",
                volume: "21191370",
                latestTradingDay: "2023-7-11",
                previousClose: "14.3200",
                change: "0.22",
                changePercent: "1.5363%")
        ]
    }
    
    static var stubsDict: [String : GlobalQuoteData] {
        var dict = [String : GlobalQuoteData]()
        stubs.forEach { globalQuoteData in
            dict[globalQuoteData.symbol!] = globalQuoteData
        }
        return dict
    }
    
    static var stub: GlobalQuoteData {
        GlobalQuoteData(
            symbol: "600104.SHH",
            open: "14.3300",
            high: "14.6000",
            low: "14.3200",
            price: "14.5400",
            volume: "21191370",
            latestTradingDay: "2023-7-11",
            previousClose: "14.3200",
            change: "0.22",
            changePercent: "1.5363%")
    }
}

#endif
