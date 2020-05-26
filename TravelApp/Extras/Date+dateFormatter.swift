//
//  Date+dateFormatter.swift
//  TravelApp
//
//  Created by Steve Bernard on 18/05/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
