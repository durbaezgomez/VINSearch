//
//  API.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

struct APIConfig {
    static let host = URL(string: Configuration.apiHost)
    
    enum Endpoint: String {
        case lookup = "/vinlookup/"
    }
}
