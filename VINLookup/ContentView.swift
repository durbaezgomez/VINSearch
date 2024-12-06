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
    @State var isSearching: Bool = false
    @State var vehicleInfo: VehicleInfo?
    
    @State private var searchError: VINSearchError?
    
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
                    
                    SearchButton(
                        action: searchAction,
                        label: isSearching ? "Searching..." : "Search",
                        systemImage: isSearching ? "" : "magnifyingglass"
                    )
                    .disabled(!isValid || isSearching)
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
                    .navigationTitle("VIN Search")
                    
                    if isSearching {
                        ProgressView()
                            .progressViewStyle(.circular)
                    } else if let error = searchError {
                        ErrorStateView(error: error)
                    } else if let vehicleInfo {
                        VehicleInfoView(info: vehicleInfo)
                    } else {
                        EmptyInfoStateView()
                    }
                }
            }
        }
    }
    
    private func searchAction() {
        // TODO - Searching 
        isSearching = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSearching = false
        }
    }
}

#Preview {
    ContentView()
}
