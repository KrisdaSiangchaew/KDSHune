//
//  String-Extensions.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation

extension String? {
    var double: Double? {
        guard let self else { return nil }
        return Double(self)
    }
    
    func toCurrency(currencyCode: String? = nil) -> String? {
        guard let value = self.double else { return nil }
        return value.formatted(.currency(code: currencyCode ?? ""))
    }
}
