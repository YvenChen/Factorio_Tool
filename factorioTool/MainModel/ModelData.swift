//
//  ModelData.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/1/4.
//

import SwiftUI

final class ModelData: ObservableObject {
    @Published var selectedGame: Game?
    @Published var selectedProducts: [Product] = [.init(" ")]
    
    var isSelectedProductsContainEmpty: Bool {
        if let lastSelectedProduct = selectedProducts.first, lastSelectedProduct.name == " " {
            return true
        } else {
            return false
        }
    }
    
    var materialsAndRecipes: Product
    
    init() {
        self.selectedGame = .factorio
        let emptyProduct: Product = .init(" ")
        self.selectedProducts = [emptyProduct]
        self.materialsAndRecipes = loadJson("materialsAndRecipes.json")
    }
}

extension ModelData {
    func getSelectedProductIndex(of product: Product) -> Int? {
        return selectedProducts.firstIndex(of: product)
    }
    
    func addEmptyProduct() {
        if !isSelectedProductsContainEmpty {
            let emptyProduct: Product = .init(" ")
            selectedProducts.insert(emptyProduct, at: 0)
        }
    }
    
    func deleteProduct(_ index: Int) {
        selectedProducts.remove(at: index)
    }
    
    func modifyProduct(modify originalProduct: Product, to newProduct: Product) throws {
        guard !selectedProducts.contains(newProduct) else { throw Notification.productExists }
        guard let index = getSelectedProductIndex(of: originalProduct) else { throw Notification.productNotExist }
        
        var newProduct = newProduct
        newProduct.requiredCount = originalProduct.requiredCount
        
        selectedProducts[index] = newProduct
    }
}

enum Game: Int, Hashable, CaseIterable, Identifiable, Codable {
    case factorio

    var id: Int { rawValue }

    var localizedName: LocalizedStringKey {
        switch self {
        case .factorio:
            return "Factorio"
        }
    }
}
