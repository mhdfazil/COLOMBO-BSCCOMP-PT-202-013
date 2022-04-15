//
//  User.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation

struct User: Decodable, Identifiable {
    var id: Int
    var name: String
    var nic: String
    var dob: Double
    var gender: String
    var email: String
    var mobile: String
    var district: String
    var latitude: Double
    var longitude: Double
    var password: String
    var cpassword: String
}
