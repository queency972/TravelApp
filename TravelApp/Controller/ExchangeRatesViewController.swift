//
//  ExchangeRatesViewController.swift
//  TravelApp
//
//  Created by Steve Bernard on 05/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

class ExchangeRatesViewController: UIViewController {
    let currency = CurrencyServices()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorONe: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    }

    @IBOutlet weak var inputValueButton: UITextField!
    @IBOutlet weak var outputValueLabel: UILabel!

    @IBAction func changed(_ sender: Any) {
        currency.getRates { (success) in
            if success {
                // Set text to label
                let myInputCurrency = (self.inputValueButton.text! as NSString).doubleValue
                var myOutputCurrency = (self.outputValueLabel.text! as NSString).doubleValue
                myOutputCurrency = myInputCurrency * CurrencyServices.activeCurrency

                // Conversion Double to String to display outputValueLabel.text
                let stringOutputCurrency = String(myOutputCurrency)
                self.outputValueLabel.text = stringOutputCurrency
            }
            else {
                self.presentAlert(title: "Error", message: "Currency download failed")
            }
        }
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inputValueButton.resignFirstResponder()
    }
}
