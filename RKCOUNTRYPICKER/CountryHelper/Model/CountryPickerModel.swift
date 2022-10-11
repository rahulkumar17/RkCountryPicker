//
//  CountryPickerModel.swift
//  CountryPicker
//
//  Created by Techugo on 20/07/21.
//

import Foundation

// MARK: - CountryPickerModelElement
struct CountryPickerModelElement: Codable {
    let name: String
    let dialCode: Int
    let code, flag: String

    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code, flag
    }
}

typealias CountryPickerModel = [CountryPickerModelElement]
