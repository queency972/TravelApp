//
//  StructTranslate.swift
//  TravelApp
//
//  Created by Steve Bernard on 14/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

struct TranslationData: Decodable {
    var data: Translations
}

struct Translations: Decodable {
    let translations: [TranslatedText]
}

struct TranslatedText: Decodable {
    let translatedText: String
}
