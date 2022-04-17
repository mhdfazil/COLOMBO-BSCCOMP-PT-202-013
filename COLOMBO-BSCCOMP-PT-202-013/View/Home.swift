//
//  Home.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-10.
//

import SwiftUI

struct Home: View {
    @State var district = "All"
    @State var isFilterShowing = false
    @State var type = ""
    @State var minPrice = ""
    @State var maxPrice = ""
    @State var isFilterApplied = false
    
    @EnvironmentObject var appState: AppState
    
    @ObservedObject var adVM = AdViewModel()
    @ObservedObject var authVM = AuthViewModel()
    
    var body: some View {
        NavigationView {
            VStack() {
                HStack() {
                    Text("Your District")
                    Picker(selection: $district, label: Text("District")) {
                        Text("All").tag("All").font(.body)
                        ForEach(0..<districts.count) { index in
                            Text(districts[index]).tag(districts[index])
                        }
                    }
                    .onChange(of: district) { tag in
                        adVM.getAds(district: district)
                    }
                    Spacer()
                    if authVM.isAuthenticated {
                        Button(action: {
                            isFilterApplied = false
                            isFilterShowing = true
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .padding(.trailing, 10)
                        }
                        .sheet(isPresented: $isFilterShowing, onDismiss: {
                            if isFilterApplied {
                                adVM.getAdsByFilter(district: district, min: minPrice, max: maxPrice, type: type)
                            }
                        }) {
                                AdFilter(type: $type, minPrice: $minPrice, maxPrice: $maxPrice, isFilterApplied: $isFilterApplied)
                        }
                    }
                }
                .padding([.leading], 10)
                
                if adVM.ads.count <= 0 {
                    Spacer()
                    Text("No ads found. New ads will be available soon!.")
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                else {
                    ScrollView() {
                        ForEach(adVM.ads, id: \.self) {
                            AdCard(ad: $0)
                        }
                    }
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .onAppear() {
                authVM.listen()
                adVM.getAds(district: district)
            }
            .onDisappear() {
                authVM.unListen()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
