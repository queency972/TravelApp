//
//  TravelAppTests.swift
//  TravelAppTests
//
//  Created by Steve Bernard on 25/03/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import XCTest
@testable import TravelApp

class TravelAppServiceTestCase: XCTestCase {

    // Tests Rates =================================================================================================================

    func testGetRatesShouldPostFailedCallbackIfError() {
        // Given
        let currencyService = CurrencyServices(ratesSession: URLRatesSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        currencyService.getRates { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetRatesShouldPostFailedCallbackIfError failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRatesShouldPostFailedCallbackIfNoData() {
        // Given
        let currencyService = CurrencyServices(ratesSession: URLRatesSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        currencyService.getRates { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetRatesShouldPostFailedCallbackIfNoData failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let currencyService = CurrencyServices(ratesSession: URLRatesSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        currencyService.getRates { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetRatesShouldPostFailedCallbackIfIncorrectResponse failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let currencyService = CurrencyServices(ratesSession: URLRatesSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        currencyService.getRates { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetRatesShouldPostFailedCallbackIfIncorrectData failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRatesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let currencyService = CurrencyServices(ratesSession: URLRatesSessionFake(data: FakeResponseData.ratesCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        currencyService.getRates { result in
            // Then
            let expectedResponse = 1.090079
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(expectedResponse == success, true)
            expectation.fulfill()
        }
    }

    // Test Weather =================================================================================================================

    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherServices = WeatherServices(session: URLWeatherSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        weatherServices.getWeather { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShouldPostFailedCallbackIfError failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherServices = WeatherServices(session: URLWeatherSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        weatherServices.getWeather { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShouldPostFailedCallbackIfNoData failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherServices = WeatherServices(session: URLWeatherSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        weatherServices.getWeather { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShouldPostFailedCallbackIfIncorrectResponse failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherServices = WeatherServices(session: URLWeatherSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        weatherServices.getWeather { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetRatesShouldPostFailedCallbackIfIncorrectData failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherServices = WeatherServices(session: URLWeatherSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        weatherServices.getWeather { result in
            // Then
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            expectation.fulfill()
        }
    }

    // Test Translate =================================================================================================================

    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let translationService = TranslationService(session: URLTranslateSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        translationService.getTranslation(text: "Bonjour") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetTranslateShouldPostFailedCallbackIfError failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translationService = TranslationService(session: URLTranslateSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        translationService.getTranslation(text: "Bonjour") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetTranslateShouldPostFailedCallbackIfNoData failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translationService = TranslationService(session: URLTranslateSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        translationService.getTranslation(text: "Bonjour") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShouldPostFailedCallbackIfIncorrectResponse failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(session: URLTranslateSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        translationService.getTranslation(text: "Bonjour") { result in
            // Then
            guard case .failure(let error) = result else {
                XCTFail("testGetTranslationShouldPostFailedCallbackIfIncorrectData failed")
                return
            }
            expectation.fulfill()
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translationService = TranslationService(session: URLTranslateSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Waiting...")
        translationService.getTranslation(text: "") { result in
        // Then
            guard case .success(let success) = result else {
                return
            }
            XCTAssertNotNil(success)
            expectation.fulfill()
        }
    }
}
