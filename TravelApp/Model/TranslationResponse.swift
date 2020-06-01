//
//  StructTranslate.swift
//  TravelApp
//
//  Created by Steve Bernard on 14/04/2020.
//  Copyright © 2020 Steve Bernard. All rights reserved.
//

import Foundation

// MARK: - TranslationD ata

struct TranslationData: Decodable {
    var data: Translations
}

// MARK: - Translations

struct Translations: Decodable {
    let translations: [TranslatedText]
}

// MARK: - Translated Text

struct TranslatedText: Decodable {
    let translatedText: String
}
