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
    case decodingError(Error)
    case networkError(Error)
    case timeout
    case rateLimitExceeded(TimeInterval)
    
    var description: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .invalidVIN:
            "Invalid VIN"
        case .decodingError(let error):
            "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            "Network error: \(error.localizedDescription)"
        case .timeout:
            "Timeout error."
        case .rateLimitExceeded(let seconds):
            "Too many requests. Please try again in \(seconds) seconds."
        }
    }
}

