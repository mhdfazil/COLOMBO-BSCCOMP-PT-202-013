//
//  ThemeTextField.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct ThemeTextField: View {
    var title: String
    @Binding var text: String
    var keyboardType = UIKeyboardType.default
    
    var body: some View {
        VStack {
            TextField(title, text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
    }
}

struct ThemeTextField_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        ThemeTextField(title: "Placeholder", text: $text)
    }
}
