//
//  AdDetail.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-17.
//

import SwiftUI
import MapKit

struct AdDetail: View {
    var ad: Ad
    @ObservedObject var locationVM = LocationViewModel()
    
    var body: some View {
        VStack() {
            ScrollView() {
                TabView {
                    ForEach(0..<ad.images!.count) { index in
                        AsyncImage(
                            url: URL(string: ad.images?[index] ?? "")!,
                            placeholder: {Image("PlaceholderLand").resizable()}
                        )
                        .scaledToFill()
                    }
                    AsyncImage(
                        url: URL(string: ad.deed ?? "")!,
                        placeholder: {Image("PlaceholderLand").resizable()}
                    )
                    .scaledToFill()
                }
                .frame(height: 340)
                .tabViewStyle(.page)
                .padding(.bottom)
                HStack {
                    Text("Price")
                        .font(.title2)
                    Spacer()
                    Text("RS \(String(format: "%.2f", ad.price))")
                        .font(.title3)
                }
                .padding([.bottom, .horizontal])
                HStack {
                    Text("Size")
                        .font(.title2)
                    Spacer()
                    Text("\(ad.size)SqFt")
                        .font(.title2)
                }
                .padding([.bottom, .horizontal])
                HStack {
                    Text("Property Type")
                        .font(.title2)
                    Spacer()
                    Text(ad.type)
                        .font(.title3)
                }
                .padding([.bottom, .horizontal])
                HStack {
                    Text("Near by")
                        .font(.title2)
                    Spacer()
                    Text(ad.nearby)
                        .font(.title3)
                }
                .padding([.bottom, .horizontal])
                HStack {
                    Text("District")
                        .font(.title2)
                    Spacer()
                    Text(ad.district)
                        .font(.title3)
                }
                .padding([.bottom, .horizontal])
                HStack {
                    Text("Location on Map")
                        .font(.title2)
                    Spacer()
                }
                ZStack {
                    Map(coordinateRegion: .constant(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: ad.latitude, longitude: ad.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [])
                        .frame(height: 300)
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 18, height: 18)
                }
                .padding(.bottom, 80)
            }
        }
        .ignoresSafeArea()
        .navigationBarTitle("", displayMode: .inline)
        .onAppear() {
            if locationVM.userLocation == nil {
                locationVM.checkLocationServiceEnabled()
            }
        }
    }
}

struct AdDetail_Previews: PreviewProvider {
    static var ad = Ad(longitude: 0, latitude: 0, price: 15000, type: "Land", nearby: "City", size: "650", district: "Ampara", images: ["https://www.goodreturns.in/img/2015/03/12-1426142991-land-home.jpg"], nic: "199711600020")
    static var previews: some View {
        AdDetail(ad: ad)
    }
}
