//
//  Double+Extension.swift
//  imdb
//
//  Created by apple on 23/10/22.
//

import Foundation

extension Double {
    
    func toCurrencyFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")/* Using Nigeria's Naira here or you can use Locale.current to get current locale, please change to your locale, link below to get all locale identifier.*/
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
