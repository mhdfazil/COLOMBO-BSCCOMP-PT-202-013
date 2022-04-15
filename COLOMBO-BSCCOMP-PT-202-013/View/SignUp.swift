//
//  SignUp.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-14.
//

import SwiftUI

struct SignUp: View {
    @State var nic = ""
    @State var name = ""
    @State var dob = Date()
    @State var gender = "Male"
    @State var mobile = ""
    @State var district = "Ampara"
    @State var email = ""
    @State var password = ""
    @State var cpassword = ""
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1922, month: 1, day: 1)
        let endComponents = DateComponents(year: 2006, month: 12, day: 31)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                Image("SignupImg")
                Spacer()
                Form {
                    ThemeTextField(title: "NIC", text: $nic)
                    ThemeTextField(title: "Name", text: $name)
                    DatePicker(selection: $dob, in: dateRange, displayedComponents: [.date], label: { Text("Date of Birth") })
                        .padding(.bottom, 10)
                    Picker(selection: $gender, label: Text("Gender")) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Other").tag("Other")
                    }
                    .padding(.bottom, 10)
                    ThemeTextField(title: "Mobile Number", text: $mobile, keyboardType: .phonePad)
                    Picker(selection: $district, label: Text("District")) {
                        ForEach(0..<districts.count) { index in
                            Text(districts[index]).tag(districts[index])
                        }
                    }
                    .padding(.bottom, 10)
                    ThemeTextField(title: "Email", text: $email, keyboardType: .emailAddress)
                    SecureField("Password", text: $password)
                        .padding(.bottom, 10)
                    SecureField("Confirm Password", text: $cpassword)
                        .padding(.bottom, 10)
                    HStack {
                        Spacer()
                        Button("Sign Up") {
                            
                        }
                        Spacer()
                    }
                }
            }
            .padding(10)
            .navigationBarTitle("Sign Up", displayMode: .inline)
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}