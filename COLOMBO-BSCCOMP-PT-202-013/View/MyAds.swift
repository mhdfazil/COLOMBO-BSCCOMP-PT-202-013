//
//  MyAds.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct MyAds: View {
    let arr = [1,2,3]
    
    var body: some View {
            VStack() {
                HStack {
                    Spacer()
                    Button("Add") {
                        
                    }
                }
                List(arr, id: \.self) { item in
                        AdCard()
                }
                .listStyle(.grouped)
            }
    }
}

struct MyAds_Previews: PreviewProvider {
    static var previews: some View {
        MyAds()
    }
}
