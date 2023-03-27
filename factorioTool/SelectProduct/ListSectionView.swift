//
//  ListSectionView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/1/4.
//

import SwiftUI

struct ListSectionView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var notificationData: NotificationData
    
    var product: Product
    
    @State private var isPopoverPresented: Bool = false
    private var requiredCount: Binding<Int> {
        Binding {
            guard let index = modelData.getSelectedProductIndex(of: product) else { return 1 }
            return modelData.selectedProducts[index].requiredCount ?? 1
        } set: { updatedValue in
            guard let index = modelData.getSelectedProductIndex(of: product) else { return }
            modelData.selectedProducts[index].requiredCount = updatedValue
        }
    }
    
    var body: some View {
        HStack(spacing: -14) {
            Image(product.iconName ?? "nil")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
                .padding()
            VStack(alignment: .leading) {
                HStack {
                    Text(product.name)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background {
                    Capsule(style: .continuous)
                        .foregroundColor(product.name == " " ? .accentColor : .gray)
                }
                .onTapGesture {
                    isPopoverPresented.toggle()
                }
                .popover(isPresented: $isPopoverPresented) {
                    selectProductPopoverView(materialsAndRecipesItems: modelData.materialsAndRecipes.items ?? []) { newProduct in
                        do {
                            try modelData.modifyProduct(modify: product, to: newProduct)
                        } catch Notification.productExists {
                            notificationData.notification = Notification.productExists
                        } catch Notification.productNotExist {
                            notificationData.notification = Notification.productNotExist
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    HStack(alignment: .bottom, spacing: 2) {
                        Text("需求:")
                            .font(.system(size: 14))
                        Text("\(requiredCount.wrappedValue)")
                            .bold()
                            .padding(.horizontal, 6)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .foregroundColor(.gray)
                            }
                        Text("个/秒")
                                .font(.system(size: 9))
                    }
                    Stepper(value: requiredCount, in: 1...Int.max, step: 1, label: {})
                }
                .padding(.horizontal, 16)
            }
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(Color("listCollectionColor"))
        }
        .transition(.move(edge: .bottom))
    }
}

struct ListSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let emptyProduct: Product = .init(" ")
            ListSectionView(product: emptyProduct)
                .environmentObject(ModelData())
        }
        .preferredColorScheme(.dark)
    }
}
