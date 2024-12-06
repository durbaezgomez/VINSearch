//
//  VINSearchValidation.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

struct SearchValidationRule: ValidationRule {
    let validate: (String) -> Bool
    let message: String
}

enum VINSearchValidation {
    private enum Constants {
        static var maxVINLength: Int = 17
    }
    
    static let allRules = [formatRule, lengthRule]
    
    static let formatRule = SearchValidationRule(
        validate: { text in
            let vinRegex = "^[A-HJ-NPR-Z0-9]*$"
            return text.range(of: vinRegex, options: .regularExpression) != nil
        },
        message: "VIN must not use special characters."
    )
    
    static let lengthRule = SearchValidationRule(
        validate: { text in text.count == Constants.maxVINLength },
        message: "VIN must be \(Constants.maxVINLength) characters long."
    )
}
 
