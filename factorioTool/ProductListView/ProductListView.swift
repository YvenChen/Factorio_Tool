//
//  ProductListView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/3/27.
//

import SwiftUI

struct ProductListView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        if let game = modelData.selectedGame {
            ScrollView(.vertical) {
                VStack {
                    ForEach(Array(modelData.selectedProducts.enumerated()), id: \.element) { index, element in
                        ListSectionView(product: $modelData.selectedProducts[index])
                            .swipeLeftAction { modelData.deleteProduct(index) }
                    }
                }
                .scaleEffect(y: -1)
            }
            .scaleEffect(y: -1)
            .safeAreaInset(edge: .top) {
                Color.clear
                    .ignoresSafeArea()
                    .frame(height: 0)
                    .background(.ultraThinMaterial)
            }
            .safeAreaInset(edge: .bottom) {
                contentBottomView
            }
            .navigationTitle(game.localizedName)
            .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("选择一个游戏")
        }
    }
    
    var contentBottomView: some View {
        HStack(spacing: 16) {
            Button {
                withAnimation(.easeInOut) {
                    modelData.addEmptyProduct()
                }
            } label: {
                HStack {
                    Spacer()
                    Text("添加")
                    Spacer()
                }
                .padding()
                .background(.ultraThinMaterial, in: Capsule(style: .continuous))
            }
            .disabled(modelData.isSelectedProductsContainEmpty)
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                NavigationLink {
                    ResultView()
                } label: {
                    Image(systemName: "arrow.forward")
                        .padding()
                        .background(.ultraThinMaterial, in: Circle())
                }
            }
        }
        .padding()
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
