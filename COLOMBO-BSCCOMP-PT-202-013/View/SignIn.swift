//
//  SignIn.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct SignIn: View {
    @State var nic = ""
    @State var password = ""
    @State var isTermsViewActive = false
    @State var isPrivacyViewActive = false
    
    let termsUrl = "https://google.com"
    let privacyUrl = "https://google.com"
    
    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                Image("LoginImg")
                Spacer()
                Form {
                    ThemeTextField(title: "NIC", text: $nic)
                    ThemeTextField(title: "Password", text: $password)
                    HStack {
                        Spacer()
                        Button("Sign In") {
                            
                        }
                        Spacer()
                    }
                    Section {
                        NavigationLink("Forget Password?", destination: ForgetPassword())
                    }
                }
                Spacer()
                HStack {
                    Text("Don't have an account? ")
                    NavigationLink("Register!", destination: SignUp())
                }
                .padding(.bottom, 10)
                HStack {
                    NavigationLink(
                        destination: InlineWeb(url: URL(string: termsUrl)!).ignoresSafeArea(),
                        isActive: $isTermsViewActive) {
                        Button("Terms & Conditions ") {
                            isTermsViewActive = true
                        }
                        .font(.footnote)
                    }
                    NavigationLink(
                        destination: InlineWeb(url: URL(string: privacyUrl)!).ignoresSafeArea(),
                        isActive: $isPrivacyViewActive) {
                        Button("Privacy Policy") {
                            isPrivacyViewActive = true
                        }
                        .font(.footnote)
                    }
                }
                .padding(.bottom, 10)
            }
            .navigationBarTitle("Sign In", displayMode: .inline)
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
