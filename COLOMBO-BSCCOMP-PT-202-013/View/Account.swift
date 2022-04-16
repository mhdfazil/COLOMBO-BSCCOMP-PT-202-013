//
//  Account.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct Account: View {
    @State var mobile = "0777862675"
    
    @ObservedObject var accountVM = AccountViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Form() {
                    Section(header: Text("Name")) {
                        Text(accountVM.user?.name ?? "Your Name")
                    }
                    Section(header: Text("NIC")) {
                        Text(accountVM.user?.nic ?? "Your NIC")
                    }
                    Section(header: Text("Date of Birth")) {
                        Text(String(accountVM.user?.dob ?? 11))
                    }
                    Section(header: Text("Gender")) {
                        Text(accountVM.user?.gender ?? "Gender")
                    }
                    Section(header: Text("Email")) {
                        Text(accountVM.user?.email ?? "Your Email")
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
                        .foregroundColor(Color.red)
                    }
                }
            }
            .navigationBarTitle("Account")
            .onAppear() {
                accountVM.getUser()
            }
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
