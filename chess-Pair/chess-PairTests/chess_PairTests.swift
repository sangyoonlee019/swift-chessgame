//
//  chess_PairTests.swift
//  chess-PairTests
//
//  Created by Grizzly.bear on 2022/06/23.
//

import XCTest
@testable import chess_Pair

class chess_PairTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func 초기흰색좌표체크() {
        let king: King = King(color: .white)
        XCTAssertTrue(king.position == Color.white.firstPosition)
    }
    
    func 초기검은색좌표체크() {
        let king: King = King(color: .black)
        XCTAssertTrue(king.position == Color.black.firstPosition)
    }
    
    func 좌로이동테스트() {
        let kingPosition = King(color: .white).position.left
        XCTAssertTrue(kingPosition == Position(rank: 1, file: .c))
    }
    
    func 우하단이동테스트() {
        let kingPosition = King(color: .white).position.downRight
        XCTAssertTrue(kingPosition == Position(rank: 1, file: .c))
    }
    /* ... */
    // 요런식으로 테스트
}
