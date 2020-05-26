//
//  WeatherAppViewController.swift
//  TravelApp
//
//  Created by Steve Bernard on 06/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

class WeatherAppViewController: UIViewController {
    let weather = WeatherServices()

    @IBOutlet var cityNameLabels: [UILabel]!
    @IBOutlet var tempLabels: [UILabel]!
    @IBOutlet var descriptionLabels: [UILabel]!
    @IBOutlet var iconImageViews: [UIImageView]!
    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorONe: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        weather.getWeather { [unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    let forecast = weatherData.list
                    for i in 0..<2 {
                        self.setupUI(cityLabel: self.cityNameLabels[i], tempLabel: self.tempLabels[i], icon: self.iconImageViews[i], description: self.descriptionLabels[i], forecast: forecast[i])
                    }

                    guard let date = forecast.first?.dt else {return}
                    self.formatDate(date: date)

                case .failure(_):
                    self.presentAlert(title: "Connection error", message: "")
                }
            }
        }
    }

     // Func allowing to format the date.
    func formatDate(date: Int) {
        let convertedDate = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: convertedDate)
        self.dateLabel.text = "\(currentDate)"
    }

    // Func allowing to setup UI
    func setupUI(cityLabel: UILabel, tempLabel: UILabel, icon: UIImageView, description: UILabel, forecast: List) {
        let convertedTemp = Int(forecast.main.temp)
        cityLabel.text = forecast.name
        icon.image  = UIImage(named: "\(forecast.weather.first!.icon)")
        description.text = forecast.weather.first!.main
        tempLabel.text = "\(convertedTemp) °C"
    }
}
