//
//  SignUpViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage = ""
    @Published var isSignInSuccess = false
    @Published var isSignUpSuccess = false
    
    let dataService: DataService
    
    init(dataService: DataService = API()) {
        self.dataService = dataService
    }
    
    func signUp(user: User) {
        if user.nic.isEmpty {
            errorMessage = "Please enter your NIC number"
            isError = true
        }
        else if !user.nic.isValidNIC {
            errorMessage = "Please enter a valid NIC number"
            isError = true
        }
        else if user.name.isEmpty {
            errorMessage = "Please enter your name"
            isError = true
        }
        else if !user.name.isValidName {
            errorMessage = "Please enter a valid name"
            isError = true
        }
        else if !user.mobile.isValidMobile {
            errorMessage = "Please enter a valid mobile number"
            isError = true
        }
        else if !user.email.isValidMail {
            errorMessage = "Please enter a valid email"
            isError = true
        }
        else if user.password.isEmpty {
            errorMessage = "Please enter a secure password"
            isError = true
        }
        else if user.password != user.cpassword {
            errorMessage = "Confirm password does not match"
            isError = true
        }
        else {
            isLoading = true
            dataService.signUp(user: user) { result in
                switch result {
                    case .success:
                        print("Success")
                        self.isLoading = false
                    case let .failure(error):
                        print(error)
                        self.isLoading = false
                        self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func signIn(nic: String, password: String) {
        if nic.isEmpty {
            errorMessage = "Please enter your NIC number"
            isError = true
        }
        else if !nic.isValidNIC {
            errorMessage = "Please enter a valid NIC number"
            isError = true
        }
        else if password.isEmpty {
            errorMessage = "Please enter your password"
            isError = true
        }
        else {
            isLoading = true
            dataService.signIn(username: nic, password: password) { result in
                switch result {
                    case .success:
                        print("Success")
                        self.isLoading = false
                        self.isError = false
                        self.errorMessage = ""
                        self.isSignInSuccess = true
                    case let .failure(error):
                        print(error)
                        self.isLoading = false
                        self.isError = true
                        self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
