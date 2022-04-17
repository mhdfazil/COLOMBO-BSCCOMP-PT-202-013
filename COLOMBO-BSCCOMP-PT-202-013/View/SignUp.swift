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
    
    @EnvironmentObject var appState: AppState
    @ObservedObject var signUpVM = SignUpViewModel()
    @ObservedObject var locationVM = LocationViewModel()
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1922, month: 1, day: 1)
        let endComponents = DateComponents(year: 2006, month: 12, day: 31)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
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
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(false)
                ThemeTextField(title: "Mobile Number", text: $mobile, keyboardType: .phonePad)
                Picker(selection: $district, label: Text("District")) {
                    ForEach(0..<districts.count) { index in
                        Text(districts[index]).tag(districts[index])
                    }
                }
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(false)
                ThemeTextField(title: "Email", text: $email, keyboardType: .emailAddress)
                SecureField("Password", text: $password)
                SecureField("Confirm Password", text: $cpassword)
                HStack {
                    Spacer()
                    Button("Sign Up") {
                        signUp()
                    }
                    Spacer()
                }
                .alert(isPresented: $signUpVM.isSignUpSuccess) {
                    Alert(title: Text("Successfull"), message: Text("You have successfully Registered with us!"), dismissButton: .cancel(Text("Okay"), action: {
                        appState.rootViewId = UUID()
                    }))
                }
            }
        }
        .padding(10)
        .navigationBarTitle("Sign Up", displayMode: .inline)
        .alert(isPresented: $signUpVM.isError) {
            Alert(title: Text("Missing something?"), message: Text(signUpVM.errorMessage), dismissButton: .cancel(Text("Okay")))
        }
    }
    
    func signUp() {
        if locationVM.userLocation == nil {
            locationVM.checkLocationServiceEnabled()
        }
        let longitude = locationVM.userLocation?.coordinate.longitude ?? 0.0
        let latitude = locationVM.userLocation?.coordinate.latitude ?? 0.0
        let user = User(name: name, nic: nic, dob: dob.timeIntervalSince1970, gender: gender, email: email, mobile: mobile, district: district, latitude: latitude, longitude: longitude, password: password, cpassword: cpassword)
        signUpVM.signUp(user: user)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
