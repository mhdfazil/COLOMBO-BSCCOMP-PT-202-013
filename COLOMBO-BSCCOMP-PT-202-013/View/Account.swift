//
//  Account.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct Account: View {
    @State var mobile = "0777862675"
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Form() {
                    Section(header: Text("Name")) {
                        Text("Your Name")
                    }
                    Section(header: Text("NIC")) {
                        Text("199711600020")
                    }
                    Section(header: Text("Date of Birth")) {
                        Text("1997/04/25")
                    }
                    Section(header: Text("Gender")) {
                        Text("Male")
                    }
                    Section(header: Text("Email")) {
                        Text("mhdfazil79@gmail.com")
                    }
                    Section(header: Text("Mobile Number")) {
                        ThemeTextField(title: "Mobile Number", text: $mobile, keyboardType: .phonePad)
                    }
                    Section() {
                        Button("Change Password") {
                            
                        }
                    }
                    Section {
                        Button("Logout") {
                            
                        }
                    }
                }
            }
            .navigationBarTitle("Account")
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
