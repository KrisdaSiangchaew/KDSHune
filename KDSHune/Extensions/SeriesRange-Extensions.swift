//
//  SeriesRange-Extensions.swift
//  KDSHune
//
//  Created by Kris on 13/7/2566 BE.
//

import Foundation
import AlphaVantageStockAPI

extension SeriesRange: Identifiable {
    public var id: Self { self }
    
    var title: String {
        switch self {
        case .daily: return "Daily"
        case .monthly: return "Monthly"
        case .weekly: return "Weekly"
        }
    }
}
