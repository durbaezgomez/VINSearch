//
//  VINSearchViewModel.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Combine
import Foundation

class VINSearchViewModel: ObservableObject {
    @Published var vin: String = ""
    @Published var isValid: Bool = false
    @Published var isSearching: Bool = false
    @Published var vehicleInfo: VehicleInfo?
    @Published var searchError: VINSearchError?
    @Published var showCancelAlert = false
    
    private var currentSearchTask: Task<Void, Never>?
    
    private let service = VINSearchService.shared
    
    func searchVIN() {
        isSearching = true
        
        Task { @MainActor in
            do {
                vehicleInfo = try await service.lookup(vin: vin)
                isSearching = false
            } catch let error as VINSearchError {
                searchError = error
            } catch {
                searchError = .networkError(error)
            }
        }
    }
    
    private func search() {
        guard !vin.isEmpty else { return }
        
        isSearching = true
        searchError = nil
        showCancelAlert = false
        
        currentSearchTask?.cancel()
        
        currentSearchTask = Task {
            Task {
                try? await Task.sleep(for: .seconds(5))
                if isSearching {
                    showCancelAlert = true
                }
            }
            
            do {
                vehicleInfo = try await service.lookup(vin: vin)
            } catch let error as VINSearchError {
                searchError = error
            } catch {
                searchError = .networkError(error)
            }
            
            if !Task.isCancelled {
                isSearching = false
                showCancelAlert = false
            }
        }
    }
    
    func cancelSearch() {
        currentSearchTask?.cancel()
        isSearching = false
        searchError = .timeout
    }
}
