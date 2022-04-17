//
//  COLOMBO_BSCCOMP_PT_202_013Tests.swift
//  COLOMBO-BSCCOMP-PT-202-013Tests
//
//  Created by Mohamed Fazil on 2022-04-09.
//

import XCTest
@testable import COLOMBO_BSCCOMP_PT_202_013

class MockDataService: DataService {
    func getAdsByFilter(district: String, type: String, min: String, max: String, complete: @escaping (Result<[Ad], Error>) -> ()) {
        
    }
    
    func signIn(username: String, password: String, complete: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    func signUp(user: User, complete: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    func getUser(complete: @escaping (Result<User, Error>) -> ()) {
        
    }
    
    func sendResetPasswordMail(complete: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    func updateAccount(mobile: String, longitude: Double, latitude: Double, complete: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    func sendResetPasswordMailByNic(nic: String, complete: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    func signOut(complete: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    func uploadImage(selectedImage: UIImage, path: String, complete: @escaping (Result<String, Error>) -> ()) {
        
    }
    
    func addAd(ad: Ad, complete: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    func getAllAds(complete: @escaping (Result<[Ad], Error>) -> ()) {
        complete(.success([Ad(longitude: 0, latitude: 0, price: 12000, type: "Land", nearby: "City", size: "120", district: "Ampara", images: ["https://"], deed: "https://", nic: "971160020v")]))
    }
    
    func getAdsByDistrict(district: String, complete: @escaping (Result<[Ad], Error>) -> ()) {
        
    }
    
    func getAdsByNic(complete: @escaping (Result<[Ad], Error>) -> ()) {
        complete(.success([Ad(longitude: 0, latitude: 0, price: 12000, type: "Land", nearby: "City", size: "120", district: "Ampara", images: ["https://"], deed: "https://", nic: "971160020v"), Ad(longitude: 11.11, latitude: -11.11, price: 1350, type: "House", nearby: "Village", size: "1200", district: "Ratnapura")]))
    }
    
}

class COLOMBO_BSCCOMP_PT_202_013Tests: XCTestCase {
    
    var sut: AdViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = AdViewModel(dataService: MockDataService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertTrue(sut.ads.isEmpty)
        sut.getAds(district: "All")
        XCTAssertEqual(sut.ads.count, 1)
    }
    
    func testExample2() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertTrue(sut.ads.isEmpty)
        sut.getAdsByNic()
        XCTAssertEqual(sut.ads.count, 2)
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
