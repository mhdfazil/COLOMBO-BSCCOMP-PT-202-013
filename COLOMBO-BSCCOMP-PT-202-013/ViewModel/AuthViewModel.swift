//
//  AuthViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-17.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        isAuthenticated = Auth.auth().currentUser != nil
    }
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            self.isAuthenticated = (user != nil)
        }
    }
    
    func unListen() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func checkAuthentication() {
        isAuthenticated = Auth.auth().currentUser != nil
    }
}
