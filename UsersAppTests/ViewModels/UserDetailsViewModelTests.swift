//
//  UserDetailsViewModelTests.swift
//  UsersAppTests
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import XCTest
@testable import UsersApp
final class UserDetailsViewModelTests: XCTestCase {
    
    var viewModel: UserDetailsViewModel!
    var repo: RepositoryMock!
    override func setUpWithError() throws {
        guard let user = LocalStorageMock().fetchUsers().first else {
            return
        }
        repo = RepositoryMock()
        viewModel = UserDetailsViewModel(user: user, repo: repo)
    }
    
    func testUsersInfo() {
        XCTAssertNil(viewModel.userImageUrl)
        XCTAssertEqual(viewModel.username, "Mr. Karl Johnson")
        XCTAssertEqual(viewModel.phone, "(268) 420-4900")
        XCTAssertEqual(viewModel.email, "karl.johnson@example.com")
        XCTAssertEqual(viewModel.gender, "male")
        XCTAssertEqual(viewModel.address, "6057 AvondaleAveNewYork-NewYork-United States")
        XCTAssertFalse(viewModel.isBookmarked)
    }
    
    func testBookmarkButtonPressed() {
        viewModel.bookmarkButtonPressed()
        XCTAssertNotNil(repo.userTobeSaved)
        viewModel.bookmarkButtonPressed()
        XCTAssertNotNil(repo.userTobeDeleted)
    }
    
    override func tearDown() {
        repo = nil
        viewModel = nil
        super.tearDown()
    }
}
