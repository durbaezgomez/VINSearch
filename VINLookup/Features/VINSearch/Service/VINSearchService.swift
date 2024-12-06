//
//  VINSearchService.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation
import OSLog

protocol VINSearchServiceProtocol {
    func lookup(vin: String) async throws -> VehicleInfo
}

class VINSearchService: NetworkService {
    static let shared = VINSearchService()
    
    init() {
        super.init()
    }
    
    func lookup(vin: String) async throws -> VehicleInfo {
        try await lookupVIN(vin)
    }
    
    private func lookupVIN(_ vin: String) async throws -> VehicleInfo {
        guard let url = APIConfig.host else {
            throw VINSearchError.invalidURL
        }
        
        do {
            let params = ["vin": vin]
            return try await performRequest(
                url: url,
                endpoint: APIConfig.Endpoint.lookup.rawValue,
                params: params
            )
        } catch is TimeoutError {
            throw VINSearchError.timeout
        } catch let urlError as URLError {
            throw VINSearchError.networkError(urlError)
        } catch let decodingError as DecodingError {
            throw VINSearchError.decodingError(decodingError)
        } catch {
            throw VINSearchError.networkError(error)
        }
    }
}
