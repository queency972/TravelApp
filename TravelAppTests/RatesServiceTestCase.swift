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
        let currencyService = CurrencyServices(ratesSession: URLRatesSessionFake(data: FakeResponseData.ratesIncorrectData, response: FakeResponseData.responseOK, error: nil))
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
}
