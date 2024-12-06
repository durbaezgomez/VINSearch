//
//  SearchButton.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct SearchButton: View {
    let action: () -> Void
    var label: String = ""
    var systemImage: String = "arrow.right"
    
    var body: some View {
        Button(action: action) {
            Label(label, systemImage: systemImage)
                .frame(maxWidth: .infinity)
        }
    }
}
