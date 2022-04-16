//
//  EditAccount.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import SwiftUI

struct EditAccount: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var accountVM = AccountViewModel()
    @ObservedObject var locationVM = LocationViewModel()
    
    @State var mobile: String
    @State var latitude: Double
    @State var longitude: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.leading)
            Form() {
                ThemeTextField(title: "Mobile Number", text: $mobile, keyboardType: .phonePad)
                Button("Set my current location") {
                    setLocation()
                }
                HStack() {
                    Spacer()
                    Button("Update") {
                        editAccount()
                    }
                    Spacer()
                }
                .alert(isPresented: $accountVM.isEditSuccess) {
                    Alert(title: Text("Success"), message: Text("Account details edited successfully!"), dismissButton: .cancel(Text("Okay"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                }
            }
        }
        .alert(isPresented: $accountVM.isError) {
            Alert(title: Text("Missing something?"), message: Text(accountVM.errorMessage), dismissButton: .cancel(Text("Okay")))
        }
    }
    
    func setLocation() {
        if locationVM.userLocation == nil {
            locationVM.checkLocationServiceEnabled()
        }
        else {
            longitude = locationVM.userLocation?.coordinate.longitude ?? 0.0
            latitude = locationVM.userLocation?.coordinate.latitude ?? 0.0
        }
    }
    
    func editAccount() {
        accountVM.updateAccount(mobile: mobile, longitude: longitude, latitude: latitude)
    }
    
}

struct EditAccount_Previews: PreviewProvider {
    @State static var text = "0123456789"
    @State static var lat = 0.0
    static var previews: some View {
        EditAccount(mobile: text, latitude: lat, longitude: lat)
    }
}
