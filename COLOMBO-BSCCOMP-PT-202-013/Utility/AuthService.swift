//
//  AuthService.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation
import FirebaseAuth

class AuthService {
    func isAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
