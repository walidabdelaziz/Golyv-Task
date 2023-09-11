//
//  ReposViewModelTests.swift
//  Golyv TaskTests
//
//  Created by Walid Ahmed on 11/09/2023.
//

import XCTest
@testable import Golyv_Task

class ReposViewModelTests: XCTestCase {

    func testGetReposSuccess() {
        // Arrange
        let reposViewModel = ReposViewModel()
        let expectation = XCTestExpectation(description: "Fetching repos")
        var repos: [Repos]?

        // Act
        reposViewModel.getRepos()
        reposViewModel.repos
            .subscribe(onNext: { reposList in
                repos = reposList
                expectation.fulfill()
            })
            .disposed(by: reposViewModel.disposeBag)

        // Assert
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(repos)
        XCTAssertGreaterThan(repos?.count ?? 0, 0)
    }

    func testGetReposFailure() {
        // Arrange
        let reposViewModel = ReposViewModel()
        let expectation = XCTestExpectation(description: "Fetching repos")
        var error: Error?

        // Act
        reposViewModel.getRepos()
        reposViewModel.error
            .subscribe(onNext: { errorResponse in
                error = errorResponse
                expectation.fulfill()
            })
            .disposed(by: reposViewModel.disposeBag)

        // Assert
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(error)
    }
    func testBindLoadNextPageTrigger() {
        // Arrange
        let reposViewModel = ReposViewModel()
        let expectation = XCTestExpectation(description: "Binding next page trigger")
        var nextPageTriggerCalled = false

        // Act
        reposViewModel.bindLoadNextPageTrigger()
        reposViewModel.loadNextPageTrigger
            .subscribe(onNext: {
                nextPageTriggerCalled = true
                expectation.fulfill()
            })
            .disposed(by: reposViewModel.disposeBag)

        // Assert
        XCTAssertFalse(nextPageTriggerCalled)
        reposViewModel.loadNextPageTrigger.onNext(())
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(nextPageTriggerCalled)
    }

}
