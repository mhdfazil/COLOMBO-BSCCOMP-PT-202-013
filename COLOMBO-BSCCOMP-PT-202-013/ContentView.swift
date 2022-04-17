//
//  ContentView.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-09.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView() {
            Home()
                .tabItem {
                    Image(systemName: "house")
                }.tag("Home")
                .id(appState.rootViewId)
            MyAds()
                .tabItem {
                    Image(systemName: "circle.grid.cross")
                }.tag("My Ads")
            Account()
                .tabItem {
                    Image(systemName: "person")
                }.tag("Account")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
