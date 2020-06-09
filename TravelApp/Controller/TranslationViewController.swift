//
//  TranslateServicesViewController.swift
//  TravelApp
//
//  Created by Steve Bernard on 07/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import UIKit

final class TranslationViewController: UIViewController {

    // MARK: - Properties

    let translate = TranslationService()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorONe: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), colorTwo: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
        targetTextView.isEditable = false
    }

    // MARK: - Outlets

    @IBOutlet private weak var sourceTextView: UITextView!
    @IBOutlet private weak var targetTextView: UITextView!
    @IBOutlet private weak var flagImage: UIImageView!

    // MARK: - Methods

    @IBAction private func changeLanguageButton(_ sender: UIButton) {
        let spainImage = #imageLiteral(resourceName: "Spain")
        let franceImage = #imageLiteral(resourceName: "France")
        if flagImage.image == spainImage {
            flagImage.image = franceImage
            translate.languageSource = "fr"
        } else {
            flagImage.image = spainImage
            translate.languageSource = "es"
        }
    }

    @IBAction private func deleteTextButton(_ sender: UIButton) {
        sourceTextView.text = nil
    }

    /// Func allowing to translate sourceTextView
    @IBAction private func translateButton() {
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
    @IBAction private func clearTextButton() {
        sourceTextView.text = nil
        targetTextView.text = nil
    }
    // Func allowing to dismiss the keyboard.
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sourceTextView.resignFirstResponder()
    }
}
