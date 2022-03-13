//
//  Functions.swift
//  MarketApp
//
//  Created by MacBook on 07/03/2022.
//

import Foundation

func convertToCurrency (_ number : Double ) -> String {
    let currancyFormatter = NumberFormatter()
    currancyFormatter.usesGroupingSeparator = true
    currancyFormatter.numberStyle =  .decimal
    currancyFormatter.locale = Locale.current
    return currancyFormatter.string(from: NSNumber(value: number))!
}
