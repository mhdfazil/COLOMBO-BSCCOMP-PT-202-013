//
//  AdCard.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-13.
//

import SwiftUI

struct AdCard: View {
    var ad: Ad
    @ObservedObject var authVM = AuthViewModel()
    
    var body: some View {
        NavigationLink(destination: authVM.isAuthenticated ? AnyView(AdDetail(ad: ad)) : AnyView(SignIn())) {
            VStack() {
                AsyncImage(
                    url: URL(string: ad.images?[0] ?? "")!,
                    placeholder: {Image("PlaceholderLand").resizable()}
                )
                    .frame(width: .none, height: 160, alignment: .top)
                VStack(alignment: .leading) {
                    Text("RS \(String(format: "%.2f", ad.price))")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("\(ad.size)SqFt \(ad.type)")
                        .font(.title)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    HStack() {
                        Image(systemName: "mappin.and.ellipse")
                        Text(ad.district)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.trailing, 10)
                        Image(systemName: "globe.americas")
                        Text(ad.nearby)
                            .font(.body)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.top, 0.1)
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
}

struct AdCard_Previews: PreviewProvider {
    static var ad = Ad(longitude: 0, latitude: 0, price: 15000, type: "Land", nearby: "City", size: "650", district: "Ampara", images: ["https://www.goodreturns.in/img/2015/03/12-1426142991-land-home.jpg"], nic: "199711600020")
    static var previews: some View {
        AdCard(ad: ad)
    }
}
