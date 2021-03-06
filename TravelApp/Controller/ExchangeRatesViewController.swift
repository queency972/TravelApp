//
//  ExchangeRatesViewController.swift
//  TravelApp
//
//  Created by Steve Bernard on 05/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

final class ExchangeRatesViewController: UIViewController {

    // MARK: - Properties

    let currency = CurrencyServices()

   // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorONe: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
    }

    // MARK: - Outlets

    @IBOutlet weak private var inputValueButton: UITextField!
    @IBOutlet weak private var outputValueLabel: UILabel!
    
    // MARK: - Methods

    // Func allowing to change outputValueLabel automatically
    @IBAction private func changed(_ sender: Any) {
        currency.getRates { [weak self] result in
            // All regarding interface must be in the mainQueue, we put this block in the mainQueue.
            DispatchQueue.main.async {
                switch result {
                case .success(let rate):
                    guard let inputValue = Double(self?.inputValueButton.text ?? "0.0") else {return}
                    let resultValue = String(inputValue * rate)
                    self?.outputValueLabel.text = resultValue

                case .failure(_):
                    self?.presentAlert(title: "Connection error", message: "")
                }
            }
        }
    }
    // Func allowing to dismiss the keyboard.
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inputValueButton.resignFirstResponder()
    }
}
