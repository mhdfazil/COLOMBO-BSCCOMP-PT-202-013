//
//  AdCard.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-13.
//

import SwiftUI

struct AdCard: View {
    let url = URL(string: "https://www.goodreturns.in/img/2015/03/12-1426142991-land-home.jpg")!
    var body: some View {
        VStack() {
            VStack() {
                AsyncImage(
                    url: url,
                    placeholder: {Image("PlaceholderLand").resizable()}
                )
                    .frame(width: UIScreen.main.bounds.width - 20, height: 180, alignment: .top)
                VStack() {
                    Text("Advertisement Name")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 24))
                    Text("Rs. 120,000")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20))
                    HStack() {
                        Image(systemName: "mappin.and.ellipse")
                        Text("District Name")
                            .font(.system(size: 14))
                        Spacer()
                        Image(systemName: "square.dashed")
                        Text("1200Sqft")
                            .font(.system(size: 14))
                        Spacer()
                        Image(systemName: "rectangle.portrait.topright.inset.filled")
                        Text("Land")
                            .font(.system(size: 14))
                    }
                    .padding(.top, 0.5)
                }
                .padding([.leading, .bottom, .trailing], 10)
            }
            .border(Color.gray, width: 1)
        }
        .padding(10)
    }
}

struct AdCard_Previews: PreviewProvider {
    static var previews: some View {
        AdCard()
    }
}
