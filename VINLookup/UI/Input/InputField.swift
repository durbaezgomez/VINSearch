//
//  InputField.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

protocol ValidationRule {
    var validate: (String) -> Bool { get }
    var message: String { get }
}

struct InputField: View {
    struct Config {
        var placeholder: String = ""
        var textInputAutocapitalization: TextInputAutocapitalization = .never
        var keyboardType: UIKeyboardType = .default
        var submitLabel: SubmitLabel = .continue
    }
    
    @Binding var text: String
    @Binding var isValid: Bool
    
    let config: Config
    let validationRules: [ValidationRule]
    let onSubmit: (() -> Void)?
    
    @State private var errorMessage: String = ""
    @FocusState var isFocused: Bool
    
    init(
        text: Binding<String>,
        isValid: Binding<Bool>,
        config: Config,
        validationRules: [ValidationRule] = [],
        onSubmit: (() -> Void)?
    ) {
        self._text = text
        self._isValid = isValid
        self.config = config
        self.validationRules = validationRules
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                TextField(config.placeholder, text: $text)
                    .textInputAutocapitalization(config.textInputAutocapitalization)
                    .keyboardType(config.keyboardType)
                    .focused($isFocused)
                    .onSubmit {
                        if validate() {
                            onSubmit?()
                            isFocused = false
                        }
                    }
                    .onChange(of: text) { _, newValue in
                        if newValue.isEmpty {
                            errorMessage = ""
                        } else {
                            _ = validate()
                        }
                    }
                    .onChange(of: isFocused) {
                        if !isFocused && text.isEmpty {
                            errorMessage = ""
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .background(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(errorMessage.isEmpty ? .clear : .red, lineWidth: 1)
                    )
                
                if !text.isEmpty {
                    Button(action: clearText) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            if !errorMessage.isEmpty  {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .transition(.opacity)
            }
        }
        .padding(.horizontal)
        .animation(.easeInOut, value: isValid)
    }
    
    private func validate() -> Bool {
        guard !text.isEmpty else { return true }
        guard !validationRules.isEmpty else { return true }
        
        for rule in validationRules {
            if !rule.validate(text) {
                isValid = false
                errorMessage = rule.message
                return false
            }
        }
        
        isValid = true
        errorMessage = ""
        return true
    }
    
    private func clearText() {
        text = ""
        isFocused = false
        isValid = false
        errorMessage = ""
    }
}

#Preview {
    @Previewable @State var isValid: Bool = false
    
    VStack(spacing: 20) {
        InputField(
            text: .constant(""),
            isValid: $isValid,
            config: .init(placeholder: "Enter VIN"),
            validationRules: VINSearchValidation.allRules,
            onSubmit: {}
        )
    }
}
