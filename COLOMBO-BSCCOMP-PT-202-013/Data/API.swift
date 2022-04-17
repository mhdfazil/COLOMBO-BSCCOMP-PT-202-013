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
import PhotosUI

protocol DataService {
    func signIn(username: String, password: String, complete: @escaping (Result<Bool, Error>) -> ())
    func signUp(user: User, complete: @escaping (Result<Bool, Error>) -> ())
    func getUser(complete: @escaping (Result<User, Error>) -> ())
    func sendResetPasswordMail(complete: @escaping (Result<Bool, Error>) -> ())
    func updateAccount(mobile: String, longitude: Double, latitude: Double, complete: @escaping (Result<Bool, Error>) -> ())
    func sendResetPasswordMailByNic(nic: String, complete: @escaping (Result<Bool, Error>) -> ())
    func signOut(complete: @escaping (Result<Bool, Error>) -> ())
    func uploadImage(selectedImage: UIImage, path: String, complete: @escaping (Result<String,Error>) -> ())
    func addAd(ad: Ad, complete: @escaping (Result<Bool, Error>) -> ())
    func getAllAds(complete: @escaping (Result<[Ad], Error>) -> ())
    func getAdsByDistrict(district: String, complete: @escaping (Result<[Ad], Error>) -> ())
    func getAdsByNic(complete: @escaping (Result<[Ad], Error>) -> ())
    func getAdsByFilter(district: String, type: String, min: String, max: String, complete: @escaping (Result<[Ad], Error>) -> ())
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
    
    func signOut(complete: @escaping (Result<Bool, Error>) -> ()) {
        do {
            try Auth.auth().signOut()
            complete(.success(true))
        } catch let err {
            print("Sign out error: \(err)")
            complete(.success(true))
        }
        UserDefaults.standard.removeObject(forKey: "userNic")
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    func uploadImage(selectedImage: UIImage, path: String, complete: @escaping (Result<String,Error>) -> ()) {
        let storageRef = Storage.storage().reference()
        let imageData = selectedImage.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let path = "/images/\(path)/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        fileRef.putData(imageData!, metadata: nil) { metaData, error in
            if(error == nil && metaData != nil) {
                fileRef.downloadURL() { url, err in
                    if err != nil {
                        complete(.failure(err!))
                    }
                    complete(.success(url?.absoluteString ?? ""))
                }
            } else {
                print("image upload error \(String(describing: error))")
                complete(.failure(error!))
            }
        }
    }
    
    func addAd(ad: Ad, complete: @escaping (Result<Bool, Error>) -> ()) {
        do {
            try self.db.collection("ads").document(ad.id ?? UUID().uuidString).setData(from: ad)
            complete(.success(true))
        } catch let error {
            print("Error writing ad to Firestore: \(error)")
            complete(.failure(error))
        }
    }
    
    func getAllAds(complete: @escaping (Result<[Ad], Error>) -> ()) {
        var ads: [Ad] = []
        db.collection("ads").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                complete(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    do {
                        try ads.append(document.data(as: Ad.self))
                    }
                    catch {
                        return
                    }
                }
                complete(.success(ads))
            }
        }
    }
    
    func getAdsByDistrict(district: String, complete: @escaping (Result<[Ad], Error>) -> ()) {
        var ads: [Ad] = []
        db.collection("ads").whereField("district", isEqualTo: district)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                complete(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    do {
                        try ads.append(document.data(as: Ad.self))
                    }
                    catch {
                        return
                    }
                }
                complete(.success(ads))
            }
        }
    }
    
    func getAdsByNic(complete: @escaping (Result<[Ad], Error>) -> ()) {
        var ads: [Ad] = []
        guard let nic = UserDefaults.standard.string(forKey: "userNic") else {
            complete(.failure("NIC not found"))
            return
        }
        db.collection("ads").whereField("nic", isEqualTo: nic)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                complete(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    do {
                        try ads.append(document.data(as: Ad.self))
                    }
                    catch {
                        return
                    }
                }
                complete(.success(ads))
            }
        }
    }
    
    func getAdsByFilter(district: String, type: String, min: String, max: String, complete: @escaping (Result<[Ad], Error>) -> ()) {
        var ads: [Ad] = []
        
        var query: Query = db.collection("ads")
        
        if district != "All" && !district.isEmpty {
            query = query.whereField("district", isEqualTo: district)
        }
        if !type.isEmpty && type != "All" {
            query = query.whereField("type", isEqualTo: type)
        }
        if !min.isEmpty && min.isNumber {
            query = query.whereField("price", isGreaterThanOrEqualTo: Double(min) ?? 0)
        }
        if !max.isEmpty && max.isNumber {
            query = query.whereField("price", isLessThanOrEqualTo: Double(max) ?? 1000000)
        }
        
        query.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                complete(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    do {
                        try ads.append(document.data(as: Ad.self))
                    }
                    catch {
                        return
                    }
                }
                complete(.success(ads))
            }
        }
    }
}
