//
//  ExtensionUIView.swift
//  TravelApp
//
//  Created by Steve Bernard on 05/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
        func setGradientBackground(colorONe: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorONe.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 2.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.6)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
