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
        weather.getWeather { (success) in
            if success{
                self.updateIBOuletUI()
            }
            else {
                self.presentAlert(title: "Error", message: "Forecast download failed")
            }
        }
        view.setGradientBackground(colorONe: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    }

    private func updateIBOuletUI() {
        self.tempLabel.text = "\(weather.currentTemp) °C"
        self.weatherDescriptionLabel.text = "\(String(describing: weather.descriptionTemp!))"
        self.weatherImageView.image = UIImage(named: "\(weather.tempIcon)")
    }
}
