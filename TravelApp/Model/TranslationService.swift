//
//  TranslateService.swift
//  TravelApp
//
//  Created by Steve Bernard on 14/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

class TranslationService: UrlEncoder {

    var languageSource: String = ""

    private var task: URLSessionDataTask?
    private var translationSession =  URLSession(configuration: .default)

    init(session: URLSession = URLSession(configuration: .default))  {
        self.translationSession = session
    }

    //Method to retrieve url of Google Translate API
    private func urlTranslation(text: String) -> String {
        guard let baseUrl = URL(string: "https://www.googleapis.com/language/translate/v2") else {return ""}
        let url = encode(baseUrl: baseUrl, parameters: [("key","AIzaSyCSKtor7x-mr2JnDUuqTFE66TKv5m7vNfU"),("source","\(languageSource)"), ("target","en"), ("format","text"), ("q","")])
        // q= Text which must be translated
        guard let translationTextConverted = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        let translationURL = "\(url)" + translationTextConverted
        let myUrl = translationURL
        return myUrl
    }
    
    //Method to get the translation from the Google Translate API with a POST request
    func getTranslation(text: String, callback: @escaping (Result<TranslationData, Error>) -> Void) {
        //let request = translationRequest(text: text)
        guard let url = URL(string: urlTranslation(text: text)) else {return}
        task?.cancel()
        task = translationSession.dataTask(with: url) { data, response, error in
            // Check if we get data.
            guard let data = data, error == nil else {
                callback(.failure(NetworkError.noData))
                return
            }
            // Check if we get code 200.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(NetworkError.noResponse))
                return
            }
            // Check if we get JSON
            guard let responseJSON = try? JSONDecoder().decode(TranslationData.self, from: data) else {
                callback(.failure(NetworkError.unDecodable))
                return
            }
            callback(.success(responseJSON))
        }
        task?.resume()
    }
}
