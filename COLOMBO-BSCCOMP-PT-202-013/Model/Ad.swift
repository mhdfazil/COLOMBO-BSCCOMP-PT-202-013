//
//  Ad.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation

struct Ad: Codable, Identifiable {
    var id: String? = UUID().uuidString
    var longitude: Double
    var latitude: Double
    var price: Double
    var type: String
    var nearby: String
    var size: String
    var district: String
    var images: [String]?
    var deed: String?
    var nic: String?
    
    mutating func setImages(images: [String]) {
        self.images = images
    }
    
    mutating func setDeed(deed: String) {
        self.deed = deed
    }
    
    mutating func setNic(nic: String) {
        self.nic = nic
    }
}
