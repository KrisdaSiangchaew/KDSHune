//
//  Utils.swift
//  KDSHune
//
//  Created by Kris on 1/7/2566 BE.
//

import Foundation

struct Utils {
    static func currency(amount: String?, currency: String? = nil, localeIdentifier: String? = nil) -> String? {
        guard let double = amount.double else { return nil }
        if let code = currency {
            return double.formatted(.currency(code: code).locale(.current))
        } else {
            return double.formatted(.currency(code: "").locale(.current))
        }
    }
}
