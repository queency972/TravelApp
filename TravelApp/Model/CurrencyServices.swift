//
//  CurrencyServices.swift
//  TravelApp
//
//  Created by Steve Bernard on 06/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

class CurrencyServices {

    static var activeCurrency: Double = 0

    // Create request, instance URLSessionTask for call network
    private var task: URLSessionDataTask?
    private var currencySession =  URLSession(configuration: .default)

    // Fonction qui permet de récupérer le données.
    func getRates(callback: @escaping (Bool) -> Void) {
        task?.cancel()

        task = currencySession.dataTask(with: Url().ratesURL) { (data, response, error) in
            // All regarding interface must be in the mainQueue, we put this block in the mainQueue.
            DispatchQueue.main.async {
                // Verification des données et si il n'y a pas d'erreur.
                guard let data = data, error == nil else {
                    callback(false)
                    return
                }
                // We check if we have an answer with 200 code.
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false)
                    return
                }
                // On decode le JSON en un dictionnaire qui a comme clé String et valeur Double.
                // We decode JSON into dictionaryn who has String Key and Double value
                guard let responseJSON = try? JSONDecoder().decode(CurrencyExchangeResponse.self, from: data)
                    // On extrait le rates
                    else {
                        callback(false)
                        return
                }
                guard let rates = responseJSON.rates["USD"] else {return}
                // guard let date = responseJSON.date else {return}
                CurrencyServices.activeCurrency = rates
                callback(true)
            }
        }
        // Launch task
        task?.resume()
    }
}
