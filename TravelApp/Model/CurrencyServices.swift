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

    // Creation d'un requete, instance URLSessionTask pour l'appel reseau
    
    private var task: URLSessionDataTask?
    private var currencySession =  URLSession(configuration: .default)

    // Fonction qui permet de récupérer le données.
    func getRates(callback: @escaping (Bool) -> Void) {
        task?.cancel()

        task = currencySession.dataTask(with: Url().ratesURL) { (data, response, error) in
            // Tout ce qui touche à l'interface doit avoir lieu dans la main Queue, On place ce block dans la Main Queue.
            DispatchQueue.main.async {
                // Verification des données et si il n'y a pas d'erreur.
                guard let data = data, error == nil else {
                    callback(false)
                    return
                }
                // On verifie que nous avons une reponse qui a pour code 200.
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false)
                    return
                }
                // On decode le JSON en un dictionnaire qui a comme clé String et valeur Double.
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
        // Lancement de la tache.
        task?.resume()
    }
}
