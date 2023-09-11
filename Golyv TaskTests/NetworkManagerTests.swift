//
//  NetworkManagerTests.swift
//  Golyv TaskTests
//
//  Created by Walid Ahmed on 11/09/2023.
//

import XCTest
@testable import Golyv_Task 

class NetworkManagerTests: XCTestCase {

    func testFetchDataSuccess() {
        // Arrange
        let networkManager = NetworkManager.shared
        let expectation = XCTestExpectation(description: "Fetching data")
        var response: Result<[Repos], Error>?

        // Act
        networkManager.fetchData(from: Consts.REPOS) { result in
            response = result
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 5.0)
        switch response {
        case .success(let repos):
            XCTAssertGreaterThan(repos.count, 0)
        case .failure(let error):
            XCTFail("Failed with error: \(error.localizedDescription)")
        case nil:
            XCTFail("No response received")
        }
    }

    func testFetchDataFailure() {
        // Arrange
        let networkManager = NetworkManager.shared
        let expectation = XCTestExpectation(description: "Fetching data")
        var response: Result<[Repos], Error>?

        // Act
        networkManager.fetchData(from: "invalidUrl") { result in
            response = result
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 5.0)
        switch response {
        case .success:
            XCTFail("Expected failure, but received success")
        case .failure(let error):
            XCTAssertNotNil(error)
        case nil:
            XCTFail("No response received")
        }
    }

}
