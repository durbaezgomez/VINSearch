//
//  VINSearchView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct VINSearchView: View {
    @ObservedObject var viewModel = VINSearchViewModel()
    
    var body: some View {
        VStack(spacing: 15) {
            InputField(
                text: $viewModel.vin,
                isValid: $viewModel.isValid,
                config: .init(
                    placeholder: "Enter VIN",
                    textInputAutocapitalization: .characters,
                    submitLabel: .search
                ),
                validationRules: VINSearchValidation.allRules,
                onSubmit: viewModel.search,
                onClear: viewModel.clearView
            )
            
            SearchButton(
                action: viewModel.search,
                label: viewModel.isSearching ? "Searching..." : "Search",
                systemImage: viewModel.isSearching ? "" : "magnifyingglass"
            )
            .disabled(viewModel.vin.isEmpty || !viewModel.isValid || viewModel.isSearching)
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            .navigationTitle("VIN Search")
            
            if viewModel.vehicleInfo == nil && !viewModel.isSearching {
                SearchHistoryView(
                    selectedVIN: $viewModel.vin,
                    onSelect: viewModel.search
                )
            }
            
            if viewModel.isSearching {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let error = viewModel.searchError {
                ErrorStateView(error: error)
            } else if viewModel.vehicleInfo == nil {
                EmptyInfoStateView()
            } else if let info = viewModel.vehicleInfo {
                NavigationLink(destination: VehicleInfoView(info: info)) {
                    Text("See vehicle details")
                }
            }
        }
        .alert("Long Running Request", isPresented: $viewModel.showCancelAlert) {
            Button("Keep Waiting", role: .cancel) {
                // Continue waiting
            }
            Button("Cancel", role: .destructive) {
                viewModel.cancelSearch()
            }
        } message: {
            Text("This request is taking longer than usual. Would you like to cancel?")
        }
    }
}
