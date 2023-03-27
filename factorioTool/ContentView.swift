//
//  ContentView.swift
//  factorioTool
//
//  Created by Yven Chen on 2023/1/4.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var games = Game.allCases
    
    var body: some View {
        NavigationSplitView {
            sidebarView
        } content: {
            ProductListView()
        } detail: {
            ResultView()
        }
    }
    
    var sidebarView: some View {
        List(games, selection: $modelData.selectedGame) { game in
            NavigationLink(value: game) {
                Image("factorio-logo")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
        }
        .navigationTitle("游戏")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}
