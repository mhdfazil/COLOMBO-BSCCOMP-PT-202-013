//
//  Ad.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation

struct Ad: Decodable, Identifiable {
    var id: Int
    var longitude: Double
    var latitude: Double
    var price: Float
    var type: String
    var nearby: String
    var size: String
    var district: String
    var images: [String]
    var deed: String
    var nic: String?
}
