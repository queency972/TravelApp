//
//  APIKeys.swift
//  TravelApp
//
//  Created by Steve Bernard on 13/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

struct Url {
    let ratesURL = URL(string: "http://data.fixer.io/api/latest?access_key=e3bd9580fafac7241a9fa5b062c66cf1")!

    let weatherNYURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=New%20york&appid=bd287ad9efd242c9e57f715b9a2fab60")!

    let translateURL =  "https://www.googleapis.com/language/translate/v2?key=AIzaSyCSKtor7x-mr2JnDUuqTFE66TKv5m7vNfU&source=fr&target=en&format=text&q="
}



