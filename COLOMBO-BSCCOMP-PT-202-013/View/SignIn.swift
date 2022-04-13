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
    var body: some View {
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
            }
            NavigationLink("Forget Password", destination: SignUp())
            Spacer()
            
        }
        .navigationBarTitle("Sign In", displayMode: .inline)
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
