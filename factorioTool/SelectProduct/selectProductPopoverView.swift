//
//  selectProductPopoverView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/3/25.
//

import SwiftUI

struct selectProductPopoverView: View {
    var materialsAndRecipesItems: [Product]
    var tapAction: (Product) throws -> Void
    
    @State private var selectedItemIndex: Int = 0
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    GeometryReader { geoProxy in
                        let singleWidth = geoProxy.size.width * 0.25
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .foregroundColor(.accentColor)
                            .padding(4)
                            .frame(width: singleWidth)
                            .offset(x: singleWidth * CGFloat(selectedItemIndex)).animation(.easeInOut(duration: 0.2), value: selectedItemIndex)
                    }
                }
                HStack {
                    ForEach(Array(materialsAndRecipesItems.enumerated()), id: \.element) { index, element in
                        Image(element.iconName ?? "nil")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fit)
                            .padding(8)
                            .onTapGesture {
                                selectedItemIndex = index
                            }
                    }
                }
            }
            .frame(maxWidth: 400)
            .fixedSize(horizontal: false, vertical: true)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 11, style: .continuous))
            .padding()
            
            ItemsTableView(items: materialsAndRecipesItems[selectedItemIndex].items ?? [], tapAction: tapAction)
        }
    }
}

struct selectProductPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        if let materialsAndRecipesItems = ModelData().materialsAndRecipes.items {
            selectProductPopoverView(materialsAndRecipesItems: materialsAndRecipesItems, tapAction: { _ in })
                .preferredColorScheme(.dark)
        } else {
            selectProductPopoverView(materialsAndRecipesItems: [], tapAction: { _ in })
        }
    }
}
