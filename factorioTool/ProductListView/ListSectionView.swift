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
    
    @Binding var product: Product
    
    @State private var isPopoverPresented: Bool = false
    @State private var requiredCount: Int = 1
//    private var requiredCount: Binding<Int> {
//        Binding {
//            return product.requiredCount ?? 1
////            return modelData.selectedProducts[index].requiredCount ?? 1
//        } set: { updatedValue in
//            product.requiredCount = updatedValue
////            modelData.selectedProducts[index].requiredCount = updatedValue
//        }
//    }
    
    var body: some View {
        HStack(spacing: -16) {
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
                        Text("\(requiredCount)")
                            .bold()
                            .padding(.horizontal, 6)
                            .background {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .foregroundColor(.gray)
                            }
                        Text("个/秒")
                            .font(.system(size: 9))
                    }
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
        .padding(.horizontal)
        .transition(.move(edge: .leading))
    }
    
    private func stepperIncrement() {
        print("stepperIncrement")
    }
    
    private func stepperDecrement() {
        print("stepperDecrement")
    }
}

//struct ListSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            let emptyProduct: Product = .init(" ")
//            ListSectionView(index: 0, product: emptyProduct)
//                .environmentObject(ModelData())
//        }
//        .preferredColorScheme(.dark)
//    }
//}
