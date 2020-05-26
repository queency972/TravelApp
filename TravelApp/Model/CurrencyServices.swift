//
//  CurrencyServices.swift
//  TravelApp
//
//  Created by Steve Bernard on 06/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noData
    case noResponse
    case unDecodable
}

class CurrencyServices {

    // Create request, instance URLSessionTask for call network
    private var task: URLSessionDataTask?
    private var currencySession : URLSession

    // 
    init(session: URLSession = URLSession(configuration: .default))  {
        self.currencySession = session
    }

    // Fonction qui permet de récupérer le données.
    func getRates(callback: @escaping (Result<Double, Error>) -> Void) {
        task?.cancel()
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=e3bd9580fafac7241a9fa5b062c66cf1") else {return}
        task = currencySession.dataTask(with: url) { (data, response, error) in
            // All regarding interface must be in the mainQueue, we put this block in the mainQueue.
            // check if you don't have any error.
            guard let data = data, error == nil else {
                callback(.failure(NetworkError.noData))
                return
            }
            // We check if we have an answer with 200 code.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(NetworkError.noResponse))
                return
            }
            // We decode JSON into dictionaryn who has String Key and Double value
            guard let responseJSON = try? JSONDecoder().decode(CurrencyExchangeResponse.self, from: data)
                // On extrait le rates
                else {
                    callback(.failure(NetworkError.unDecodable))
                    return
            }
            guard let rates = responseJSON.rates["USD"] else {return}
            // guard let date = responseJSON.date else {return}
            callback(.success(rates))
            
        }
        // Launch task
        task?.resume()
    }
}
