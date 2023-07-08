//
//  Ticker-Identifiable.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

extension Ticker: Identifiable {
    public var id: UUID { UUID() }
}

extension Ticker: Equatable {
    public static func == (lhs: Ticker, rhs: Ticker) -> Bool {
        lhs.symbol == rhs.symbol
    }
}
