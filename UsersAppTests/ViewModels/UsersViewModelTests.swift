//
//  UsersViewModelTests.swift
//  UsersAppTests
//
//  Created by Mohamed Elmalhey on 02/09/2023.
//

import XCTest
@testable import UsersApp

final class UsersViewModelTests: XCTestCase {
    var viewModel: UsersViewModel?
    var repo: RepositoryMock?
    
    override func setUp() {
        super.setUp()
        repo = RepositoryMock()
        viewModel = UsersViewModel(repo: repo!)
    }
    
    func testNumberOfUsers() {
        let expectation = expectation(description: "number of users ")
        viewModel?.onStateUpdate = {  state in

            switch state {
            case .populated:
                expectation.fulfill()
                
            default:
                break
            }
        }
        viewModel?.getUsers()
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(self.viewModel?.numberOfUsers, 3)

    }
    
    func testGetUser() {
        let expectation = expectation(description: "get user")
        viewModel?.onStateUpdate = {  state in
           
            switch state {
            case .populated:
                expectation.fulfill()
                
            default:
                break
            }
        }
        viewModel?.getUsers()
        wait(for: [expectation], timeout: 5)
        let user = self.viewModel?.getUser(with: 0)
        XCTAssertEqual(user?.email ?? "", "karl.johnson@example.com")
    
    }
    
    func testSearchUsers() {
        let searchExpectation = expectation(description: "searching ..")
        let usersLoadedExpectation = expectation(description: "users loaded successfully ..")
        viewModel?.onStateUpdate = { state in
            switch state {
            case .searching:
                searchExpectation.fulfill()
                
            case .populated:
                usersLoadedExpectation.fulfill()
                
            default: break
            }
        }
        
        viewModel?.getUsers()
        wait(for: [usersLoadedExpectation], timeout: 5)
        viewModel?.searchUsers(with: "john")
        wait(for: [searchExpectation], timeout: 5)
        XCTAssertEqual(self.viewModel?.numberOfUsers, 1)
    }
    
    func testRefreshList() {
        viewModel?.refreshList()
        XCTAssertEqual(repo?.page ?? 0 , 2)
        XCTAssertEqual(viewModel?.state, .firstTimeLoading)
    }
    
    func testDidBookmark() {
        let expectation = expectation(description: "bookmark a user")
        viewModel?.onStateUpdate = { state in
            switch state {
            case .populated:
                expectation.fulfill()
                
            default:
                break
            }
        }
        viewModel?.getUsers()
        wait(for: [expectation], timeout: 1)
        
        let user = viewModel?.getUser(with: 0)
        viewModel?.didBookmark(user, UserTableViewCell())
        XCTAssertTrue(user?.isBookMarked ?? false)
    }

    override func tearDown() {
        repo =  nil
        viewModel = nil 
        super.tearDown()
    }
}
