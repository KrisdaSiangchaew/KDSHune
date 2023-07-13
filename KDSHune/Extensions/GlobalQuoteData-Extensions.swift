//
//  GlobalQuote-Extensions.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

extension GlobalQuoteData {
    var symbolText: String {
        if let symbol { return symbol } else { return "" }
    }
    
    var priceText: String {
        if let text = price.toCurrency() { return text } else { return "-" }
    }
    
    var diffText: String {
        if let text = change.toCurrency() {
            return text.hasPrefix("-") ? text : "+\(text)"
        } else {
            return "-"
        }
    }
    
    var openText: String {
        if let text = price.toCurrency() { return text } else { return "-" }
    }
    
    var highText: String {
        if let text = high.toCurrency() { return text } else { return "-" }
    }
    
    var changeText: String {
        if let text = change.toCurrency() { return text } else { return "-" }
    }
}
