//
//  AdViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-17.
//

import Foundation
import UIKit
import SwiftUI

class AdViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isError = false
    @Published var isSuccess = false
    @Published var errorMessage = ""
    @Published var ads = [Ad]()
    
    let dataService: DataService
    
    init(dataService: DataService = API()) {
        self.dataService = dataService
    }
    
    func addAd(ad: Ad, images: [UIImage], deedImage: [UIImage]) {
        var ad = ad
        print("Advertisement \(ad)")
        if ad.type.isEmpty {
            errorMessage = "Please select your property type"
            isError = true
        }
        else if ad.nearby.isEmpty {
            errorMessage = "Please select property nearby field"
            isError = true
        }
        else if ad.district.isEmpty {
            errorMessage = "Please select district"
            isError = true
        }
        else if ad.nearby.isEmpty {
            errorMessage = "Please select property nearby field"
            isError = true
        }
        else if ad.price <= 0 {
            errorMessage = "Please enter a valid price"
            isError = true
        }
        else if ad.size.isEmpty {
            errorMessage = "Please enter property size in SqFt"
            isError = true
        }
        else if !ad.size.isNumber {
            errorMessage = "Please enter a valid property size"
            isError = true
        }
        else if images.count <= 0 {
            errorMessage = "Please select at least 1 image"
            isError = true
        }
        else if deedImage.count <= 0 {
            errorMessage = "Please select the deed image"
            isError = true
        }
        else {
            isLoading = true
            var imagePaths: [String] = []
            let dispatchGroup = DispatchGroup()
            
//            upload images
            for image in images {
                dispatchGroup.enter()
                dataService.uploadImage(selectedImage: image, path: "ads") { result in
                    switch result {
                        case .success(let path):
                            imagePaths.append(path)
                            ad.setImages(images: imagePaths)
                            dispatchGroup.leave()
                        case .failure(let err):
                            print("Images upload error.......\(err.localizedDescription)")
                            self.isError = true
                            self.errorMessage = err.localizedDescription
                            self.isLoading = false
                            dispatchGroup.leave()
                    }
                }
            }
            
//            upload deed image
            dispatchGroup.enter()
            dataService.uploadImage(selectedImage: deedImage[0], path: "deeds") { result in
                switch result {
                case .success(let path):
                    ad.setDeed(deed: path)
                    dispatchGroup.leave()
                case .failure(let err):
                    self.isError = true
                    self.errorMessage = err.localizedDescription
                    self.isLoading = false
                    dispatchGroup.leave()
                }
            }
            
//            set nic
            guard let nic = UserDefaults.standard.string(forKey: "userNic") else {
                self.isError = true
                self.errorMessage = "NIC not found"
                self.isLoading = false
                return
            }
            ad.setNic(nic: nic)
            
            dispatchGroup.notify(queue: .main) { [self] in
                if !isError {
                    dataService.addAd(ad: ad) { result in
                        switch result {
                            case .success(_):
                                self.isError = false
                                self.isLoading = false
                                self.isSuccess = true
                            case .failure(let err):
                                self.isLoading = false
                                self.isError = true
                                self.errorMessage = err.localizedDescription
                        }
                    }
                }
            }
        }
    }
    
    func getAds(district: String) {
        if district == "All" {
            dataService.getAllAds() { result in
                switch result {
                    case .success(let ads):
                        self.isError = false
                        self.isLoading = false
                        self.ads = ads
                    case .failure(let err):
                        self.isLoading = false
                        self.isError = true
                        self.errorMessage = err.localizedDescription
                }
            }
        } else {
            dataService.getAdsByDistrict(district: district) { result in
                switch result {
                    case .success(let ads):
                        self.isError = false
                        self.isLoading = false
                        self.ads = ads
                    case .failure(let err):
                        self.isLoading = false
                        self.isError = true
                        self.errorMessage = err.localizedDescription
                }
            }
        }
    }
    
    func getAdsByNic() {
        dataService.getAdsByNic() { result in
            switch result {
                case .success(let ads):
                    self.isError = false
                    self.isLoading = false
                    self.ads = ads
                case .failure(let err):
                    self.isLoading = false
                    self.isError = true
                    self.errorMessage = err.localizedDescription
            }
        }
    }
    
    func validatedAdFilter(min: String, max: String) -> Bool {
        if !min.isEmpty && !min.isNumber {
            self.isError = true
            self.errorMessage = "Enter a valid min price"
            return false
        } else if !max.isEmpty && !max.isNumber {
            self.isError = true
            self.errorMessage = "Enter a valid max price"
            return false
        }
        else if !min.isEmpty && !max.isEmpty {
            if Double(max) ?? 1 <= Double(min) ?? 0 {
                self.isError = true
                self.errorMessage = "Max price should be greater than min price"
                return false
            }
        }
        return true
    }
    
    func getAdsByFilter(district: String, min: String, max: String, type: String) {
        if !min.isEmpty && !min.isNumber {
            self.isError = true
            self.errorMessage = "Enter a valid min price"
        } else if !max.isEmpty && !max.isNumber {
            self.isError = true
            self.errorMessage = "Enter a valid max price"
        }
        else if !min.isEmpty && !max.isEmpty {
            if Double(max) ?? 1 <= Double(min) ?? 0 {
                self.isError = true
                self.errorMessage = "Max price should be greater than min price"
            }
        } else {
            isLoading = true
            dataService.getAdsByFilter(district: district, type: type, min: min, max: max) { result in
                switch result {
                    case .success(let ads):
                        self.isError = false
                        self.isLoading = false
                        self.ads = ads
                    case .failure(let err):
                        self.isLoading = false
                        self.isError = true
                        self.errorMessage = err.localizedDescription
                }
            }
        }
    }
}
