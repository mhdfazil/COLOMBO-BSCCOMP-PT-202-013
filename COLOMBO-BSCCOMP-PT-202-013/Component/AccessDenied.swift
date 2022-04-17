//
//  AccessDenied.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import SwiftUI

struct AccessDenied: View {
    var text: String = "SignIn to view your Account"
    var body: some View {
        VStack(alignment: .center) {
            Image("DeniedImg")
                .padding(.bottom, 20)
            NavigationLink(text, destination: SignIn())
                .isDetailLink(false)
        }
    }
}

struct AccessDenied_Previews: PreviewProvider {
    static var previews: some View {
        AccessDenied()
    }
}
