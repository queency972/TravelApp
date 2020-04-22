//
//  WeatherServices.swift
//  TravelApp
//
//  Created by Steve Bernard on 06/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

class WeatherServices {

    private var task: URLSessionDataTask?
    private var currencySession =  URLSession(configuration: .default)

    private var _tempIcon: String!
    private var _cityName: String!
    private var _date: String!
    private var _currentTemp: Double!
    private var _descriptionTemp: String!

    var cityName: String {
        if _cityName == nil { _cityName = "" }
        return _cityName
    }

    var date: String {
        if _date == nil { _date = "" }
        return _date
    }

    var descriptionTemp: String! {
        if _descriptionTemp == nil { _descriptionTemp = "" }
        return _descriptionTemp
    }

    var currentTemp: Double {
        if _currentTemp == nil { _currentTemp = 0.0 }
        return _currentTemp
    }

    var tempIcon: String {
        if _tempIcon == nil { _tempIcon = "" }
        return _tempIcon
    }

    func getWeather(callback: @escaping (Bool) -> Void) {
        task?.cancel()
        task = URLSession.shared.dataTask(with: Url().weatherNYURL) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil  {
                    do {

                        guard let response = response as? HTTPURLResponse, response.statusCode == 200
                            else { callback(false)
                                return }

                        guard let mainResponseJSON = try? JSONDecoder().decode(CurrentLocalWeather.self, from: data)
                            else { callback(false)
                                return }

                        guard let responseJSON = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { callback(false)
                                return }

                        guard let weatherDetails = responseJSON["weather"] as? [[String:Any]]
                            else { callback(false)
                                return }

                        let date = mainResponseJSON.dt
                        self._descriptionTemp = (weatherDetails.first?["description"] as? String)
                        self._tempIcon = (weatherDetails.first?["icon"] as! String)
                        let convertedDate = Date(timeIntervalSince1970: TimeInterval(date))
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .medium
                        dateFormatter.timeStyle = .none
                        let currentDate = dateFormatter.string(from: convertedDate)
                        self._date = "\(currentDate)"
                        let downloadedTemp = mainResponseJSON.main["temp"]!
                        self._currentTemp = (downloadedTemp - 273.15).rounded(toPlaces: 0)
                    }
                    catch {
                        print("Error!!!")
                    }; callback(true)
                }
            }
        };task?.resume()
    }
}
