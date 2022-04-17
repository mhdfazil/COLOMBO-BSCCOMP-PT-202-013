//
//  Account.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct Account: View {
    @State var isEditPresented = false
    @ObservedObject var accountVM = AccountViewModel()
    
    let dateFormatter = DateFormatter()
    let authService = AuthService()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if !authService.isAuthenticated() {
                    AccessDenied()
                } else {
                    Form() {
                        Section(header: Text("Name")) {
                            Text(accountVM.user?.name ?? "")
                        }
                        Section(header: Text("NIC")) {
                            Text(accountVM.user?.nic ?? "")
                        }
                        Section(header: Text("Date of Birth")) {
                            Text(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(accountVM.user?.dob ?? 0.0))))
                        }
                        Section(header: Text("Gender")) {
                            Text(accountVM.user?.gender ?? "")
                        }
                        Section(header: Text("Email")) {
                            Text(accountVM.user?.email ?? "")
                        }
                        Section(header: Text("Mobile Number")) {
                            Button(accountVM.user?.mobile ?? "") {
                                isEditPresented = true
                            }
                            .fullScreenCover(isPresented: $isEditPresented) {
                                EditAccount(mobile: accountVM.mobile, latitude: accountVM.user?.latitude ?? 0.0, longitude: accountVM.user?.longitude ?? 0.0)
                            }
                        }
                        Section() {
                            Button("Reset Password") {
                                accountVM.resetPassword()
                            }
                            .alert(isPresented: $accountVM.isResetPwdMailSend) {
                                Alert(title: Text("Reset Password"), message: Text("Reset password mail has been sent to your email address."), dismissButton: .cancel(Text("Okay")))
                            }
                        }
                        Section {
                            Button("Logout") {
        //                            accountVM.logout
                            }
                            .foregroundColor(Color.red)
                        }
                    }
                    .onAppear() {
                        accountVM.getUser()
                    }
                }
            }
            .navigationBarTitle("Account")
            .alert(isPresented: $accountVM.isError) {
                Alert(title: Text("Missing something?"), message: Text(accountVM.errorMessage), dismissButton: .cancel(Text("Okay")))
            }
        }
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
