//
//  ContentView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State var vin: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchField(
                        text: $vin,
                        placeholder: "Enter VIN",
                        onSubmit: searchAction
                    )
                    
                    Button(action: searchAction) {
                        Label("Search", systemImage: "magnifyingglass")
                            .frame(maxWidth: .infinity)
                    }
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
