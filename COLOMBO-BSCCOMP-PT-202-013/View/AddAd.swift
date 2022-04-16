//
//  AddAd.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct AddAd: View {
    @State var type = "Land"
    @State var nearBy = "Town"
    @State var price = ""
    @State var size = ""
    @State var district = "Ampara"
    
    var body: some View {
        VStack() {
            Form() {
                Picker(selection: $type, label: Text("Property Type")) {
                    Text("Land").tag("Land")
                    Text("House").tag("House")
                }
                Picker(selection: $type, label: Text("Near By")) {
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
                Section(header: Text("Images")) {
                    Text("Maximum 9 images")
                        .font(.footnote)
                }
                Section(header: Text("Deed Image")) {
                    
                }
            }
        }
        .navigationBarTitle("Add Property Ad")
    }
}

struct AddAd_Previews: PreviewProvider {
    static var previews: some View {
        AddAd()
    }
}
