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
    
    func testFirstPosition() {
        let whiteKing: King = King(color: .white, position: Color.white.firstPosition)
        XCTAssertTrue(whiteKing.isMakable(position: Color.white.firstPosition))
        XCTAssertFalse(whiteKing.isMakable(position: Color.black.firstPosition))
        
        
        let blackKing: King = King(color: .black, position: Color.black.firstPosition)
        XCTAssertTrue(blackKing.isMakable(position: Color.black.firstPosition))
        XCTAssertFalse(blackKing.isMakable(position: Color.white.firstPosition))
    }
    
    func moveTest() {
        let to = Color.white.firstPosition.left
        let whiteKing: King = King(color: .white, position: Color.white.firstPosition)
        if let whiteKingPosition = whiteKing.position.left, let to = to {
            //"성공"
            XCTAssertTrue(whiteKingPosition == to)
        } else {
            //실패
        }
        
        
        

    }
    
    func 맨왼쪽상단에있을때() {
        let to = Position(rank: 1, file: .a)
        let whiteKing: King = King(color: .white, position: to)
        XCTAssertTrue(whiteKing.position.left == nil)
    }

}
