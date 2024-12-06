//
//  VINSearchError.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

enum VINSearchError: Error {
    case invalidURL
    case invalidVIN
    case invalidResponse(Int)
    case decodingError(Error)
    case networkError(Error)
    case timeout
    
    var description: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalidVIN:
            "Invalid VIN"
        case .invalidResponse:
            "Invalid response"
        case .decodingError(let error):
            "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            "Network error: \(error.localizedDescription)"
        case .timeout:
            "Timeout error."
        }
    }
}

