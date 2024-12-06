//
//  VINSearchViewModel.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Combine

class VINSearchViewModel: ObservableObject {
    @Published var vin: String = ""
    @Published var isValid: Bool = false
    @Published var isSearching: Bool = false
    @Published var vehicleInfo: VehicleInfo?
    @Published var searchError: VINSearchError?
    
    func searchVIN() {
        
    }
}
