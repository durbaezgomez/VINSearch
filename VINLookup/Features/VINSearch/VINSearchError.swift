//
//  VINSearchError.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

enum VINSearchError: Error {
    case invalidVIN
    case invalidResponse
    case networkError(Error)
}

