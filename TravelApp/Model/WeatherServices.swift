//
//  WeatherServices.swift
//  TravelApp
//
//  Created by Steve Bernard on 06/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

class WeatherServices: UrlEncoder {

    private var task: URLSessionDataTask?
    private var weatherSession =  URLSession(configuration: .default)

    init(session: URLSession = URLSession(configuration: .default))  {
        self.weatherSession = session
    }

    // func to get forecast.
    func getWeather(callback: @escaping (Result<CurrentLocalWeather, Error>) -> Void) {
        task?.cancel()
        guard let baseUrl = URL(string: "http://api.openweathermap.org/data/2.5/group") else {return}
        let url = encode(baseUrl: baseUrl, parameters: [("id","5128581,2988507"),("units","metric"), ("appid","bd287ad9efd242c9e57f715b9a2fab60")])
        task = weatherSession.dataTask(with: url) { (data, response, error) in
            // Check if we get data.
            guard let data = data, error == nil else {
                callback(.failure(NetworkError.noData))
                return
            }
            // Check if we get code 200.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200
                else { callback(.failure(NetworkError.noResponse))
                    return }
            // Check if we get JSON
            guard let mainResponseJSON = try? JSONDecoder().decode(CurrentLocalWeather.self, from: data)
                else { callback(.failure(NetworkError.noData))
                    return }
            callback(.success(mainResponseJSON))

        };task?.resume()
    }
}
