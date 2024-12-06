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
    let region: String
    let wmi: String
    let vds: String
    let vis: String
    let year: Int
    
    enum CodingKeys: String, CodingKey {
        case vin
        case country
        case region
        case wmi
        case vds
        case vis
        case year
    }
}
