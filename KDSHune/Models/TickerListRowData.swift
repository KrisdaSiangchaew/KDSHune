//
//  TickerListRowData.swift
//  KDSHune
//
//  Created by Kris on 30/6/2566 BE.
//

import Foundation

typealias PriceChange = (price: String, change: String)

struct TickerListRowData {
    enum RowType {
        case main
        case search(isSaved: Bool, onButtonTap: () -> Void)
    }
    
    let symbol: String?
    let name: String?
    let price: PriceChange?
    let type: RowType
}
