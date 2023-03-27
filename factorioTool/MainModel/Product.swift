//
//  Product.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/1/4.
//

import Foundation

/**
 Product or material in factorio.
 */
struct Product: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var iconName: String?
    var timeRequired: Double?
    var recipe: Set<RecipeElement>?
    var output: Double?
    var items: [Product]?
    var requiredCount: Int?
    
    init(_ name: String) {
        self.id = UUID()
        self.name = name
        self.iconName = "nil"
        self.requiredCount = 1
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

/**
 Include material and the number of required.
 */
struct RecipeElement: Hashable, Codable {
    var materialName: String
    var count: Double
    
    init(_ materialName: String, _ count: Double) {
        self.materialName = materialName
        self.count = count
    }
}
