//
//  VINSearchService.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation
import OSLog

actor VINSearchService {
    private let service: NetworkService
    
    private init(service networkingService: NetworkService = .shared) {
        self.service = networkingService
    }
    
    func lookupVIN(_ vin: String) async throws -> VehicleInfo {
        guard let url = APIConfig.host else {
            throw VINSearchError.invalidURL
        }
        
        do {
            let params = ["vin": vin]
            return try await service.performRequest(
                url: url,
                endpoint: APIConfig.Endpoint.lookup.rawValue,
                params: params
            )
        } catch is TimeoutError {
            throw VINSearchError.timout
        } catch let urlError as URLError {
            throw VINSearchError.networkError(urlError)
        } catch let decodingError as DecodingError {
            throw VINSearchError.decodingError(decodingError)
        } catch {
            throw VINSearchError.networkError(error)
        }
    }
}
