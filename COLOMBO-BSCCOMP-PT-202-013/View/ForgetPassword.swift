//
//  ForgetPassword.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct ForgetPassword: View {
    @ObservedObject var accountVM = AccountViewModel()
    @State var nic = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                ThemeTextField(title: "Enter your NIC", text: $nic)
                HStack {
                    Spacer()
                    Button("Continue") {
                        accountVM.resetPasswordWithNic(nic: nic)
                    }
                    .alert(isPresented: $accountVM.isResetPwdMailSend) {
                        Alert(title: Text("Reset Password"), message: Text("Reset password mail has been sent to your email address."), dismissButton: .cancel(Text("Okay")))
                    }
                    Spacer()
                }
            }
        }
        .navigationBarTitle("Reset Password")
        .alert(isPresented: $accountVM.isError) {
            Alert(title: Text("Missing something?"), message: Text(accountVM.errorMessage), dismissButton: .cancel(Text("Okay")))
        }
    }
}

struct ForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPassword()
    }
}
