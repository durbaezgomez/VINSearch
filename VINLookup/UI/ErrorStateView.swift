//
//  ErrorStateView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct ErrorStateView: View {
    let error: VINSearchError
    
    var body: some View {
        ContentUnavailableView {
            Label("Error occured", systemImage: "exclamationmark.triangle")
        } description: {
            Text(description)
        }
    }
    
    var description: String {
        switch error {
        case .invalidVIN:
            return "Invalid VIN"
        case .invalidResponse:
            return "Invalid response"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ErrorStateView(error: .invalidResponse)
}
