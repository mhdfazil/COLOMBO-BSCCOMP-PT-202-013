//
//  AddAd.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct AddAd: View {
    @State var type = ""
    @State var nearBy = ""
    @State var price = ""
    @State var size = ""
    @State var district = ""
    @State var longitude: Double = 6.927079
    @State var latitude: Double = 79.861244
    @State var locations = [Mark]()
    
    @State var isMapShowing = false
    @State var isImagePickerShowing = false
    @State var isDeedPickerShowing = false
    @State var selectedImages: [UIImage]?
    @State var selectedDeedImage: [UIImage]?
    
    @ObservedObject var adVM = AdViewModel()
    @ObservedObject var locationVM = LocationViewModel()
    
    var body: some View {
        VStack() {
            Form() {
                Picker(selection: $type, label: Text("Property Type")) {
                    Text("Land").tag("Land")
                    Text("House").tag("House")
                }
                Picker(selection: $nearBy, label: Text("Near By")) {
                    Text("Town").tag("Town")
                    Text("Village").tag("Village")
                }
                Picker(selection: $district, label: Text("District")) {
                    ForEach(0..<districts.count) { index in
                        Text(districts[index]).tag(districts[index])
                    }
                }
                ThemeTextField(title: "Price", text: $price, keyboardType: .numberPad)
                ThemeTextField(title: "Size in SqFt", text: $size, keyboardType: .numberPad)
                Section(header: Text("Location")) {
                    Button("Select Location") {
                        if locationVM.userLocation == nil {
                            locationVM.checkLocationServiceEnabled()
                        } else {
                            isMapShowing = true
                        }
                    }
                    .fullScreenCover(isPresented: $isMapShowing) {
                        MapView(locations: $locations)
                    }
                }
                Section(header: Text("Images")) {
                    Button("Upload Images") {
                        isImagePickerShowing = true
                    }
                    Text("Maximum 9 images")
                        .font(.footnote)
                }
                .sheet(isPresented: $isImagePickerShowing, onDismiss: nil) {
                    ImagePicker(selectedImages: $selectedImages, isPickerShowing: $isImagePickerShowing, limit:9)
                }
                Section(header: Text("Deed Image")) {
                    Button("Upload Images") {
                        isDeedPickerShowing = true
                    }
                }
                .sheet(isPresented: $isDeedPickerShowing, onDismiss: nil) {
                    ImagePicker(selectedImages: $selectedDeedImage, isPickerShowing: $isDeedPickerShowing, limit:1)
                }
                HStack(alignment: .center) {
                    Spacer()
                    Button("Add Advertisement") {
                        addAd()
                    }
                    Spacer()
                }
                .alert(isPresented: $adVM.isSuccess) {
                    Alert(title: Text("Successfull"), message: Text("Your advertisement successfully added!"), dismissButton: .cancel(Text("Okay")) {
                            type = ""
                            nearBy = ""
                            price = ""
                            size = ""
                            district = ""
                            longitude = 6.927079
                            latitude = 79.861244
                            locations = [Mark]()
                        })
                }
            }
        }
        .navigationBarTitle("Add Property Ad")
        .alert(isPresented: $adVM.isError) {
            Alert(title: Text("Missing something?"), message: Text(adVM.errorMessage), dismissButton: .cancel(Text("Okay")))
        }
    }
    
    func addAd() {
        if !locations.isEmpty {
            longitude = locations[0].coordinate.longitude
            latitude = locations[0].coordinate.latitude
        }
        let ad = Ad(longitude: longitude, latitude: latitude, price: Double(price) ?? 0, type: type, nearby: nearBy, size: size, district: district)
        adVM.addAd(ad: ad, images: selectedImages ?? [UIImage](), deedImage: selectedDeedImage ?? [UIImage]())
    }
}

struct AddAd_Previews: PreviewProvider {
    static var previews: some View {
        AddAd()
    }
}
