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
            Text(error.description)
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        ErrorStateView(error: .invalidVIN)
        ErrorStateView(error: .invalidResponse(1))
        ErrorStateView(error: .networkError(NSError(domain: "", code: 1)))
    }
}
