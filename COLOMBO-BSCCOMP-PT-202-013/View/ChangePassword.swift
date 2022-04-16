//
//  ChangePassword.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import SwiftUI

struct ChangePassword: View {
    @State var currentPassword = ""
    @State var password = ""
    @State var cpassword = ""
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var accountVM = AccountViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("< Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.leading)
            Form() {
                SecureField("Current Password", text: $currentPassword)
                SecureField("New Password", text: $password)
                SecureField("Confirm New Password", text: $cpassword)
                Section {
                    HStack() {
                        Spacer()
                        Button("Update") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}
