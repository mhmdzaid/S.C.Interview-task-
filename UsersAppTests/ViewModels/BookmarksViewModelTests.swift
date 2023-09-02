//
//  BookmarksViewModelTests.swift
//  UsersAppTests
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import XCTest
@testable import UsersApp

final class BookmarksViewModelTests: XCTestCase {
    var viewModel: BookmarksViewModel!
    var mockedRepo: RepositoryMock!
    override func setUp() {
        super.setUp()
        mockedRepo = RepositoryMock()
        viewModel = BookmarksViewModel(repo: mockedRepo)
    }
    
    func testGetBookmarkedUsers() {
        let expectation = expectation(description: "fetch bookmarked users")
        viewModel.onUserRemoval = { _ in
            expectation.fulfill()
        }
        viewModel.getBookmarkedUsers()
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.numberOfUsers, 1)
        XCTAssertTrue(mockedRepo.dataSource is LocalStorageMock)
    }
    
    func testGetUser() {
        let expectation = expectation(description: "fetch bookmarked users to get a user")
        viewModel.onUserRemoval = { _ in
            expectation.fulfill()
        }
        viewModel.getBookmarkedUsers()
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.getUser(with: 0).name, "Mr. Karl Johnson")
    }

    func testDidBookmarkUser() {
        let expectation = expectation(description: "fetch bookmarked users to remove a user")
        viewModel.onUserRemoval = { state in
            switch state {
            case .populated:
                expectation.fulfill()
            default:
                break
            }
        }
        viewModel.getBookmarkedUsers()
        wait(for: [expectation], timeout: 1)
        let user = viewModel.getUser(with: 0)
        viewModel.didBookmark(user, UserTableViewCell())
        XCTAssertEqual(viewModel.numberOfUsers, 0)
    }

    override func tearDown() {
        mockedRepo = nil
        viewModel = nil
        super.tearDown()
    }
    
}
