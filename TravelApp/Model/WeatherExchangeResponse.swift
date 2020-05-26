//
//  WeatherExchangeResponse.swift
//  TravelApp
//
//  Created by Steve Bernard on 13/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - CurrentLocalWeather
struct CurrentLocalWeather: Decodable {
    let list: [List]
}

// MARK: - List
struct List: Decodable {
    let weather: [Weather]
    let main: Main
    let dt, id: Int
    let name: String
}

// MARK: - Main
struct Main: Decodable {
    let temp: Double
}

// MARK: - Weather
struct Weather: Decodable {
    let main, icon: String
}
