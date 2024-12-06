//
//  SearchHistory.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct SearchHistoryView: View {
    @Binding var selectedVIN: String
    let onSelect: () -> Void
    
    @State private var history = SearchHistory.shared
    
    var body: some View {
        if !history.items.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Recent Searches")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Button("Clear", role: .destructive) {
                        history.clear()
                    }
                    .font(.subheadline)
                }
                
                ForEach(history.items) { item in
                    Button {
                        selectedVIN = item.vin
                        onSelect()
                    } label: {
                        HStack {
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundStyle(.secondary)
                            Text(item.vin)
                                .foregroundStyle(.primary)
                            Spacer()
                            Text(item.timestamp.formatted(.relative(presentation: .named)))
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
        }
    }
}

#Preview {
    SearchHistoryView(
        selectedVIN: .constant("GSDGSDGDSFSKJKJK"),
        onSelect: {}
    )
}
