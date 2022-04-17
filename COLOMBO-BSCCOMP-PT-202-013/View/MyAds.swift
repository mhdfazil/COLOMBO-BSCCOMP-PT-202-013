//
//  MyAds.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct MyAds: View {
    let authService = AuthService()
    
    @ObservedObject var adVM = AdViewModel()
    @ObservedObject var authVM = AuthViewModel()
    
    var body: some View {
        NavigationView {
            VStack() {
                if !authService.isAuthenticated() {
                    AccessDenied(text: "SignIn to view My Ads")
                } else {
                    HStack {
                        Spacer()
                        NavigationLink("Add", destination: AddAd())
                    }
                    .padding(.trailing)
                    
                    if adVM.ads.count <= 0 {
                        Spacer()
                        Text("No ads found. Add your property ads to view here.")
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    else {
                        ScrollView(showsIndicators: false) {
                            ForEach(adVM.ads, id: \.self) {
                                AdCard(ad: $0)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("My Ads")
            .onAppear() {
                authVM.listen()
                adVM.getAdsByNic()
            }
            .onDisappear() {
                authVM.unListen()
            }
        }
    }
}

struct MyAds_Previews: PreviewProvider {
    static var previews: some View {
        MyAds()
    }
}
