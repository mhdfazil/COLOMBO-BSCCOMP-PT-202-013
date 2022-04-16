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
    @Published var user: User?
    @Published var errorMessage = ""
    
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
}
