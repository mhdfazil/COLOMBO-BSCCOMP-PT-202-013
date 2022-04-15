//
//  API.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation
import Firebase
import FirebaseAuth

protocol DataService {
    
}

class API: DataService {
    
    let db = Firestore.firestore()
    
    func signIn(username: String, password: String) {
        
    }
    
    func signUp(user: User, complete: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
          
        }
    }
}
