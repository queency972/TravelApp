//
//  Double+Rounded.swift
//  TravelApp
//
//  Created by Steve Bernard on 18/05/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    // Round the double to decilal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
