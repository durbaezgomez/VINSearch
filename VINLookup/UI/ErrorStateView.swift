//
//  ErrorStateView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct ErrorStateView: View {
    var errorMessage: String
    
    var body: some View {
        ContentUnavailableView {
            Label("Error occured", systemImage: "exclamationmark.triangle")
        } description: {
            Text(errorMessage)
        }
    }
}

#Preview {
    ErrorStateView(errorMessage: "Test message")
}
