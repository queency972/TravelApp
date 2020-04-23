//
//  ExchangeResponse.swift
//  TravelApp
//
//  Created by Steve Bernard on 13/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

struct CurrencyExchangeResponse: Codable {
    let rates: [String:Double]
    let date: String
}

