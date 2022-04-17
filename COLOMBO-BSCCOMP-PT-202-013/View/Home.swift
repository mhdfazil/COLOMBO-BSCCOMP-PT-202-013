//
//  Home.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-10.
//

import SwiftUI

struct Home: View {
    @State var district = "All"
    let authService = AuthService()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
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
                        Spacer()
                    }
                    .padding([.leading], 10)
//                    List(arr, id: \.self) { item in
//                            AdCard()
//                    }
//                    .listStyle(.grouped)
    //                .listRowSeparator(.hidden)
                    ScrollView() {
                        ForEach(0..<4) { _ in
                            AdCard()
                        }
                    }
                }
                
            }.navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
