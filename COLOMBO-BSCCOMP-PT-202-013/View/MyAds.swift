//
//  MyAds.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct MyAds: View {
    let authService = AuthService()
    
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
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<4) {_ in
                            AdCard()
                        }
                    }
                }
            }
            .navigationBarTitle("My Ads", displayMode: .inline)
        }
    }
}

struct MyAds_Previews: PreviewProvider {
    static var previews: some View {
        MyAds()
    }
}
