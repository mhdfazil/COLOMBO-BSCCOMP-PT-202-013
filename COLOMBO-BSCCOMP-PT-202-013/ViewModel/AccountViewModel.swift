//
//  AccountViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation

class AccountViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isError = false
    @Published var isResetPwdMailSend = false
    @Published var isEditSuccess = false
    @Published var user: User?
    @Published var errorMessage = ""
    @Published var mobile = ""
    
    let dataService: DataService
    
    init(dataService: DataService = API()) {
        self.dataService = dataService
    }
    
    func getUser() {
        isLoading = true
        dataService.getUser { result in
            switch result {
                case let .success(user):
                    print("Success")
                    self.mobile = user.mobile
                    self.user = user
                    self.isLoading = false
                    self.isError = false
                case let .failure(error):
                    print(error)
                    self.isLoading = false
                    self.isError = true
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func resetPassword() {
        isLoading = true
        dataService.sendResetPasswordMail() { result in
            switch result {
                case .success:
                    print("Success")
                    self.isLoading = false
                    self.isResetPwdMailSend = true
                    print("isResetPwdMailSend")
                case let .failure(error):
                    print("Reset Password Error: \(error)")
                    self.isLoading = false
                    self.isError = true
                    self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func resetPasswordWithNic(nic: String) {
        if nic.isEmpty {
            errorMessage = "Please enter your NIC number"
            isError = true
        }
        else if !nic.isValidNIC {
            errorMessage = "Please enter a valid NIC number"
            isError = true
        }
        else {
            isLoading = true
            dataService.sendResetPasswordMailByNic(nic: nic) { result in
                switch result {
                    case .success:
                        print("Success")
                        self.isLoading = false
                        self.isResetPwdMailSend = true
                        print("isResetPwdMailSend")
                    case let .failure(error):
                        print("Reset Password Error: \(error)")
                        self.isLoading = false
                        self.isError = true
                        self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func updateAccount(mobile: String, longitude: Double, latitude: Double) {
        if !mobile.isValidMobile {
            errorMessage = "Please enter a valid mobile number"
            isError = true
        } else {
            dataService.updateAccount(mobile: mobile, longitude: longitude, latitude: latitude) { result in
                switch result {
                    case .success:
                        print("Success")
                        self.isLoading = false
                        self.isEditSuccess = true
                    case let .failure(error):
                        print(error)
                        self.isLoading = false
                        self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
