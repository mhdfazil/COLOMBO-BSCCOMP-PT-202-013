//
//  MapView.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-17.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 25.7617,
            longitude: 80.1918
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 10,
            longitudeDelta: 10
        )
    )
    @Binding var locations: [Mark]
    
    var body: some View {
        ZStack() {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(
                    coordinate: location.coordinate,
                    anchorPoint: CGPoint(x: 0.5, y: 0.7)
                ) {
                    VStack{
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                            .onTapGesture {
                                let index: Int = locations.firstIndex(where: {$0.id == location.id})!
                                locations[index].show.toggle()
                            }
                    }
                }
            }
            Circle()
                .fill(Color.blue)
                .frame(width: 18, height: 18)
            VStack {
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Button("Select") {
                        locations = [Mark(coordinate: region.center)]
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    @State static var location =
//    static var previews: some View {
//        MapView()
//    }
//}

struct Mark: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    var show = false
}
