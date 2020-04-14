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
}

struct Main: Codable {
    var main: [String:Double]
}

class Weather: Codable {
    var weather: [String:String]
//    let icon: String
}
