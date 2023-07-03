//
//  GlobalQuote-Extensions.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

extension GlobalQuoteData {
    var priceText: String? {
        price.toCurrency(currencyCode: "USD")
    }
    
    var diffText: String? {
        guard let text = change.toCurrency() else { return nil }
        return text.hasPrefix("-") ? text : "+\(text)"
    }
}
