//
//  ContentView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State var vin: String = ""
    @State var isValid: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    InputField(
                        text: $vin,
                        isValid: $isValid,
                        config: .init(
                            placeholder: "Enter VIN",
                            textInputAutocapitalization: .characters,
                            submitLabel: .search
                        ),
                        validationRules: VINSearchValidation.allRules,
                        onSubmit: searchAction
                    )
                    
                    Button(action: searchAction) {
                        Label("Search", systemImage: "magnifyingglass")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(!isValid)
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                    
                    // EmptyView or VehicleInfoView or ErrorView
                }
            }
        }
        .navigationTitle("VIN Search")
    }
    
    private func searchAction() {
        // TODO
    }
}

#Preview {
    ContentView()
}
