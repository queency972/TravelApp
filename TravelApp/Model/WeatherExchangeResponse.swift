//
//  WeatherExchangeResponse.swift
//  TravelApp
//
//  Created by Steve Bernard on 13/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

struct CurrentLocalWeather: Codable {
    var dt: Int
    var main: [String:Double]
}
