//
//  WeatherServices.swift
//  TravelApp
//
//  Created by Steve Bernard on 06/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

class WeatherServices {

    private let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=New%20york&appid=bd287ad9efd242c9e57f715b9a2fab60")!
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

    func getWeather() {
         task?.cancel()

         task = URLSession.shared.dataTask(with: weatherURL) { (data, response, error) in
            if let data = data, error == nil  {
                do {
                    guard let dateResponseJSON = try? JSONDecoder().decode(CurrentLocalWeather.self, from: data)
                       else {
                      //callback(false)
                            return
                    }
                    print("La date est", dateResponseJSON.dt)

                    guard let mainResponseJSON = try? JSONDecoder().decode(Main.self, from: data)
                      else {
                    //callback(false)
                            return
                    }
                    print("La temperature est de", mainResponseJSON.main["temp"]!)

                    guard let weatherResponseJSON = try? JSONDecoder().decode([Weather].self, from: data)
                      else {
                    //callback(false)
                            return
                    }
                    print("La description du temps est", weatherResponseJSON[Weather])



                    //guard let weatherDetails = responseJSON["weather"] as? [[String:Any]], let weatherMain = responseJSON["main"] as? [String:Any] else {return}
                    //let date = (responseJSON["dt"] as? Double as Any)
//                    self._currentTemp = (weatherMain["temp"] as! Double)
//                    self._descriptionTemp = (weatherDetails.first?["description"] as? String)
//                    self._tempIcon = (weatherDetails.first?["icon"] as? String)
//                    let convertedDate = Date(timeIntervalSince1970: date as! TimeInterval)
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateStyle = .medium
//                    dateFormatter.timeStyle = .none
//                    let currentDate = dateFormatter.string(from: convertedDate)
//                    self._date = "\(currentDate)"
//                    print(self._date!)
//                    print(self._descriptionTemp!)
//                    print(self._currentTemp!)
//                    print(self._tempIcon!)
                }
                catch {
                    print("Error!!!")
                }
            }
        };task?.resume()
    }
}



