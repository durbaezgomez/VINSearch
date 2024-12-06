//
//  EmptyInfoStateView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct EmptyInfoStateView: View {
    var body: some View {
        ContentUnavailableView(
            "No Vehicle Information",
            systemImage: "car",
            description: Text("Enter a VIN number to search for vehicle details")
        )
    }
}

#Preview {
    EmptyInfoStateView()
}
