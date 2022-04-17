//
//  AdFilter.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-17.
//

import SwiftUI

struct AdFilter: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var type: String
    @Binding var minPrice: String
    @Binding var maxPrice: String
    @Binding var isFilterApplied: Bool
    
    @ObservedObject var adVM = AdViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Button("Filter") {
                    isFilterApplied = true
                    if adVM.validatedAdFilter(min: minPrice, max: maxPrice) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding()
            Form {
                Section(header: Text("Price Range")) {
                    HStack {
                        ThemeTextField(title: "Min Price", text: $minPrice, keyboardType: .numberPad)
                        Spacer()
                        ThemeTextField(title: "Max Price", text: $maxPrice, keyboardType: .numberPad)
                    }
                }
                Section(header: Text("Property Type")) {
                    Picker(selection: $type, label: Text("Property Type")) {
                        Text("All").tag("All")
                        Text("Land").tag("Land")
                        Text("House").tag("House")
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .alert(isPresented: $adVM.isError) {
            Alert(title: Text("Missing something"), message: Text(adVM.errorMessage), dismissButton: .cancel(Text("Okay")))
        }
    }
}

struct AdFilter_Previews: PreviewProvider {
    @State static var type = ""
    @State static var min = ""
    @State static var max = ""
    @State static var applied = false
    static var previews: some View {
        AdFilter(type: $type, minPrice: $min, maxPrice: $max, isFilterApplied: $applied)
    }
}
