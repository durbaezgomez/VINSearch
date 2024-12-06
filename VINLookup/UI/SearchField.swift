//
//  SearchField.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct SearchField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    let onSubmit: (() -> Void)?

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .focused($isFocused)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
}
