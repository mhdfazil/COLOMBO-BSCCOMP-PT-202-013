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
                AsyncImage(
                    url: url,
                    placeholder: {Image("PlaceholderLand").resizable()}
                )
                    .frame(width: .none, height: 160, alignment: .top)
                VStack(alignment: .leading) {
                    Text("Rs. 120,000")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("Advertisement Name")
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    HStack() {
                        Image(systemName: "mappin.and.ellipse")
                        Text("District Name")
                            .font(.body)
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "square.dashed")
                        Text("1200Sqft")
                            .font(.body)
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "rectangle.portrait.topright.inset.filled")
                        Text("Land")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 0.5)
                }
                .padding()
            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding([.horizontal, .top])
    }
}

struct AdCard_Previews: PreviewProvider {
    static var previews: some View {
        AdCard()
    }
}
