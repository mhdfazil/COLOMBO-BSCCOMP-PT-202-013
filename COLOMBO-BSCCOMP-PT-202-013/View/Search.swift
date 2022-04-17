//
//  Search.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct Search: View {
    @State var searchText = ""
    @State var isShowingFilter = false
    
    let authService = AuthService()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if !authService.isAuthenticated() {
                    AccessDenied(text: "SignIn to Search desired properties")
                } else {
                    SearchBar(searchText: $searchText)
                        .padding(.top, -10)
                }
            }
            .navigationBarTitle("Search")
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
