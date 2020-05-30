//
//  FakeResponseData.swift
//  TravelAppTests
//
//  Created by Steve Bernard on 25/05/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

// Manage test data. Simulate response server when we do a call network.
class FakeResponseData {

    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: nil)

    // Simulate error. Get an implementation protocol Error.
    class RateError: Error {}
    static let error = RateError()

    // Simulate Json send by data.fixer.io (File Rates.json)
    static var ratesCorrectData: Data {
        // Bundle tests
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Rates", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    // Simulate Json send by openweather.com (File Weather.json)
    static var weatherCorrectData: Data {
        // Bundle tests
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    // Simulate Json send by googleTranslate.com (File Translate.json)
    static var translateCorrectData: Data {
        // Bundle tests
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    // constant type Data. Simulate an Incorrect json with an encoding for exemple: utf8 
    static let incorrectData = "erreur".data(using: .utf8)!
}
