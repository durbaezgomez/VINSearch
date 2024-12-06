//
//  SearchHistory.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import Foundation

struct SearchHistoryItem: Identifiable, Equatable, Codable {
    let id: UUID
    let vin: String
    let timestamp: Date
    
    init(vin: String) {
        self.id = UUID()
        self.vin = vin
        self.timestamp = Date()
    }
}

@Observable
class SearchHistory {
    static let shared = SearchHistory()
    private let maxItems = 5
    private let userDefaultsKey = "searchHistory"
    
    var items: [SearchHistoryItem] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init() {
        loadFromUserDefaults()
    }
    
    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([SearchHistoryItem].self, from: data) {
            items = decoded
        }
    }
    
    func add(_ vin: String) {
        items.removeAll { $0.vin == vin }
        items.insert(SearchHistoryItem(vin: vin), at: 0)

        if items.count > maxItems {
            items = Array(items.prefix(maxItems))
        }
    }
    
    func clear() {
        items.removeAll()
    }
}
