//
//  Configuration.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

enum Configuration {
    private static let configFileName = "Config"
    
    static func value<T>(for key: String) -> T {
        guard let path = Bundle.main.path(forResource: configFileName, ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict[key] as? T else {
            fatalError("Could not find value for key: \(key) in Config.plist")
        }
        return value
    }
    
    static var apiHost: String {
        value(for: "API_HOST")
    }
    
    static var apiKey: String {
        value(for: "API_KEY")
    }
}
