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

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        weather.getWeather()
        updateIBOuletUI() // Dois etre ds la fonction getWeather()
        view.setGradientBackground(colorONe: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), colorTwo: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    }

    func updateIBOuletUI() {
        self.tempLabel.text = "\(weather.currentTemp)"
        self.weatherDescriptionLabel.text = "\(String(describing: weather.descriptionTemp))"
        self.weatherImageView.image = UIImage(named: "\(weather.tempIcon)")
    }
}
