//
//  TranslateServicesViewController.swift
//  TravelApp
//
//  Created by Steve Bernard on 07/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    let translate = TranslationService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorONe: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        targetTextView.isEditable = false
    }

    @IBOutlet weak var sourceTextView: UITextView!
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var LanguageImage: UIImageView!

    @IBAction func changeLanguageButton(_ sender: UIButton) {
        let spainImage = #imageLiteral(resourceName: "Spain")
        let franceImage = #imageLiteral(resourceName: "France")
        if LanguageImage.image == spainImage {
            LanguageImage.image = franceImage
            translate.languageSource = "fr"
        } else {
            LanguageImage.image = spainImage
            translate.languageSource = "es"
        }
    }

    @IBAction func deleteTextButton(_ sender: UIButton) {
        sourceTextView.text = nil
    }
    // Func allowing to translate sourceTextView
    @IBAction func translateButton() {
        guard let sourceText = sourceTextView.text else { return }
        translate.getTranslation(text: sourceText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let responseJson):
                    let translation = responseJson.data.translations
                    let textTranslated = translation[0].translatedText
                    self?.targetTextView.text = textTranslated
                case .failure(_):
                    self?.presentAlert(title: "Connection error", message: "")
                }
            }
        }
    }
    // Func allowing to clear all text.
    @IBAction func clearTextButton() {
        sourceTextView.text = nil
        targetTextView.text = nil
    }
    // Func allowing to dismiss the keyboard.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sourceTextView.resignFirstResponder()
    }
}
