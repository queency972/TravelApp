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
        view.setGradientBackground(colorONe: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), colorTwo: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
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
                self.presentAlert()
            }
        }
    }

        private func presentAlert() {
            // On crée l'alerte.
            let alertVC = UIAlertController(title: "Error", message: "Currency download failed", preferredStyle: .alert)
            // On crée l'action.
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            // Et on présente l'alerte.
            present(alertVC, animated: true, completion: nil)
        }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inputValueButton.resignFirstResponder()
    }
}
