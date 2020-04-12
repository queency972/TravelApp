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
        currency.getRates()
        // Set text to label
        let myInputCurrency = (inputValueButton.text! as NSString).doubleValue
        var myOutputCurrency = (outputValueLabel.text! as NSString).doubleValue
        myOutputCurrency = myInputCurrency * CurrencyServices.activeCurrency

        // Conversion Double to String to display outputValueLabel.text
        let stringOutputCurrency = String(myOutputCurrency)
        outputValueLabel.text = stringOutputCurrency
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inputValueButton.resignFirstResponder()
    }










    
}
