//
//  ItemsTableView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/3/26.
//

import SwiftUI

struct ItemsTableView: View {
    @Environment(\.dismiss) var dismiss
    
    var items: [Product]
    var tapAction: (Product) throws -> Void
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(items) { row in
                    if let rowItems = row.items {
                        LazyVGrid(columns: [.init(.fixed(50))], alignment: .leading) {
                            ForEach(rowItems) { element in
                                Image(element.iconName ?? "")
                                    .resizable(resizingMode: .stretch)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(4)
                                    .onTapGesture {
                                        try? tapAction(element)
                                        dismiss()
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct ItemsTableView_Previews: PreviewProvider {
    static var previews: some View {
        if let items = ModelData().materialsAndRecipes.items?[0].items {
            ItemsTableView(items: items, tapAction: { _ in })
                .preferredColorScheme(.dark)
        } else {
            ItemsTableView(items: [], tapAction: { _ in })
        }
    }
}
