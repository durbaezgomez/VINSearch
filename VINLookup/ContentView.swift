//
//  ContentView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VINSearchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
