//
//  Account.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct Account: View {
    @State var isEditPresented = false
    @State var isLogoutConfirmPresented = false
    @ObservedObject var accountVM = AccountViewModel()
    @ObservedObject var authVM = AuthViewModel()
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if !authVM.isAuthenticated {
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
                            Text(doubleToDateString(double: accountVM.user?.dob ?? 0))
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
                                isLogoutConfirmPresented = true
                            }
                            .foregroundColor(Color.red)
                        }
                        .alert(isPresented: $isLogoutConfirmPresented) {
                            Alert(
                                title: Text("Are you sure you want to logout?"),
                                message: Text("We will miss you."),
                                primaryButton: .destructive(Text("Logout")) {
                                    accountVM.logout()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                    .onAppear() {
                        authVM.checkAuthentication()
                        accountVM.getUser()
                    }
                }
            }
            .navigationBarTitle("Account")
            .alert(isPresented: $accountVM.isError) {
                Alert(title: Text("Missing something?"), message: Text(accountVM.errorMessage), dismissButton: .cancel(Text("Okay")))
            }
            .onAppear() {
                authVM.listen()
            }
            .onDisappear() {
                authVM.unListen()
            }
        }
    }
    
    func doubleToDateString(double: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: double))
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
