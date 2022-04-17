//
//  Home.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-10.
//

import SwiftUI

struct Home: View {
    @State var district = "All"
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
                                .font(.body)
                        }
                    }
                    .onChange(of: district) { tag in
                        adVM.getAds(district: district)
                    }
                    Spacer()
                }
                .padding([.leading], 10)
                ScrollView() {
                    ForEach(adVM.ads, id: \.self) {
                        AdCard(ad: $0)
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
