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

    // Getting data
    // Creation d'un requete, instance URLSessionTask pour l'appel reseau

    private let ratesURL = URL(string: "http://data.fixer.io/api/latest?access_key=e3bd9580fafac7241a9fa5b062c66cf1")!
    private var task: URLSessionDataTask?
    private var currencySession =  URLSession(configuration: .default)

    // Fonction qui permet de récupérer le données.
    func getRates() {
        task?.cancel()

        task = currencySession.dataTask(with: ratesURL) { (data, response, error) in
            // Tout ce qui touche à l'interface doit avoir lieu dans la main Queue, On place ce block dans la Main Queue.
            DispatchQueue.main.async {
                // Verification des données et si il n'y a pas d'erreur.
                guard let data = data, error == nil else {
                   // callback(false, nil)
                    return
                }
                print("OK")
                // On verifie que nous avons une reponse qui a pour code 200.
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                   // callback(false, nil)
                    return
                }
                print("OK!")
                // On decode le JSON en un dictionnaire qui a comme clé String et valeur Double.
                guard let responseJSON = try? JSONDecoder().decode([String:Double].self, from: data),
                    // On extrait le rates
                    let rates = responseJSON["rates"] else {
                       // callback(false, nil)
                        return
                }
                print(rates)
                // CurrencyServices.activeCurrency = rates.object(forKey: "USD")! as! Double
                // On crée l'objet quote
                // callback(true)
                // print(CurrencyServices.activeCurrency)
            }
        }
        // Lancement de la tache.
        task?.resume()
    }
}
