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

    @IBAction func deleteTextButton(_ sender: UIButton) {
        sourceTextView.text = nil
    }
    
    @IBAction func translateButton() {
        guard let sourceText = sourceTextView.text else { return }
        translate.getTranslation(text: sourceText) { (success, translation) in
            if success, let translation = translation?.data.translations {
                let textTranslated = translation[0].translatedText
                self.targetTextView.text = textTranslated
                //self.textTranslatedTextView.textColor = UIColor.black
            } else {
                self.presentAlert(title: "Error", message: "Translation's data download failed")
            }
        }
    }

    @IBAction func clearTextButton() {
        sourceTextView.text = nil
        targetTextView.text = nil
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sourceTextView.resignFirstResponder()
    }
}
