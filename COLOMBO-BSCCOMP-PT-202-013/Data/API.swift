//
//  API.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol DataService {
    func signIn(username: String, password: String, complete: @escaping (Result<Bool, Error>) -> ())
    func signUp(user: User, complete: @escaping (Result<Bool, Error>) -> ())
    func getUser(complete: @escaping (Result<User, Error>) -> ())
    func sendResetPasswordMail(complete: @escaping (Result<Bool, Error>) -> ())
    func updateAccount(mobile: String, longitude: Double, latitude: Double, complete: @escaping (Result<Bool, Error>) -> ())
    func sendResetPasswordMailByNic(nic: String, complete: @escaping (Result<Bool, Error>) -> ())
}

class API: DataService {
    
    let db = Firestore.firestore()
    
    func signIn(username: String, password: String, complete: @escaping (Result<Bool, Error>) -> ()) {
        let userRef = db.collection("users").document(username)
        userRef.getDocument() { (document, err) in
            guard err == nil else {
                print("Error getting documents: ", err ?? "Unknown Error")
                complete(.failure(err!))
                return
            }
            
            if let document = document, document.exists {
               let user = document.data()
               if let user = user {
                   print("user", user)
                   let email = user["email"] as? String ?? ""
                   
                   Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                     if error != nil {
                         complete(.failure(error!))
                     } else {
                         complete(.success(true))
                         UserDefaults.standard.set(authResult!.user.uid, forKey: "userId")
                         UserDefaults.standard.set(user["nic"], forKey: "userNic")
                     }
                   }
               }
           }
        }
    }
    
    func signUp(user: User, complete: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if error != nil {
                complete(.failure(error!))
            } else {
                do {
                    try self.db.collection("users").document(user.nic).setData(from: user)
                    UserDefaults.standard.set(authResult!.user.uid, forKey: "userId")
                    UserDefaults.standard.set(user.nic, forKey: "userNic")
                    complete(.success(true))
                } catch let error {
                    print("Error writing city to Firestore: \(error)")
                    complete(.failure(error))
                }
            }
        }
    }
    
    func getUser(complete: @escaping (Result<User, Error>) -> ()) {
        guard let nic = UserDefaults.standard.string(forKey: "userNic") else {
            complete(.failure("NIC not found"))
            return
        }
        let userRef = db.collection("users").document(nic)
        userRef.getDocument(as: User.self) { result in
            switch result {
                case .success(let user):
                    print("City: \(user)")
                    complete(.success(user))
                case .failure(let error):
                    print("Error decoding city: \(error)")
                    complete(.failure(error))
            }
        }
    }
    
    func sendResetPasswordMail(complete: @escaping (Result<Bool, Error>) -> ()) {
        guard let nic = UserDefaults.standard.string(forKey: "userNic") else {
            complete(.failure("NIC not found"))
            return
        }
        let userRef = db.collection("users").document(nic)
        userRef.getDocument(as: User.self) { result in
            switch result {
                case .success(let user):
                    print("User: \(user)")
                    Auth.auth().sendPasswordReset(withEmail: user.email) { error in
                        if error != nil {
                            complete(.failure(error!))
                            return
                        }
                        complete(.success(true))
                    }
                case .failure(let error):
                    print("Error decoding user: \(error)")
                    complete(.failure(error))
            }
        }
    }
    
    func updateAccount(mobile: String, longitude: Double, latitude: Double, complete: @escaping (Result<Bool, Error>) -> ()) {
        guard let nic = UserDefaults.standard.string(forKey: "userNic") else {
            complete(.failure("NIC not found"))
            return
        }
        let userRef = db.collection("users").document(nic)
        userRef.updateData([
            "mobile": mobile,
            "longitude": longitude,
            "latitude": latitude
        ]) { err in
            if err != nil {
                complete(.failure(err!))
                return
            }
            complete(.success(true))
        }
    }
    
    func sendResetPasswordMailByNic(nic: String, complete: @escaping (Result<Bool, Error>) -> ()) {
        let userRef = db.collection("users").document(nic)
        userRef.getDocument(as: User.self) { result in
            switch result {
                case .success(let user):
                    print("User: \(user)")
                    Auth.auth().sendPasswordReset(withEmail: user.email) { error in
                        if error != nil {
                            complete(.failure(error!))
                            return
                        }
                        complete(.success(true))
                    }
                case .failure(let error):
                    print("Error decoding city: \(error)")
                    complete(.failure(error))
            }
        }
    }
}
