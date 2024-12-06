//
//  VehicleInfo.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

struct VehicleInfo: Codable {
    let vin: String
    let country: String
    let manufacturer: String?
    let model: String?
    let vehicleClass: String?
    let region: String
    let wmi: String
    let vds: String
    let vis: String
    let year: Int
    
    enum CodingKeys: String, CodingKey {
        case vin
        case country
        case manufacturer
        case model
        case vehicleClass = "class"
        case region
        case wmi
        case vds
        case vis
        case year
    }
    
    var isPremiumField: (String) -> Bool = { value in
        value == "Only available for premium subscribers."
    }
    
    var manufacturerValue: String {
        manufacturer.map { isPremiumField($0) ? "Premium Only" : $0 } ?? "N/A"
    }
    
    var modelValue: String {
        model.map { isPremiumField($0) ? "Premium Only" : $0 } ?? "N/A"
    }
    
    var vehicleClassValue: String {
        vehicleClass.map { isPremiumField($0) ? "Premium Only" : $0 } ?? "N/A"
    }
}
