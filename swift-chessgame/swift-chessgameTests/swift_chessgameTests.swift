//
//  swift_chessgameTests.swift
//  swift-chessgameTests
//
//  Created by 이상윤 on 2022/06/20.
//

import XCTest
@testable import swift_chessgame

class BoardTests: XCTestCase {
    func testBoard_initialize() {
        let board = Board()
        board.initialize()
        
        XCTAssertEqual(8, board.whitePieces.count)
        XCTAssertEqual(8, board.blackPieces.count)
        XCTAssertEqual(16, board.pieces.count)
    }
    
    func testCalculate_score() {
        let board = Board()
        board.create(Pawn(color: .black), at: Coordinate(rank: .one, file: .A))
        board.create(Pawn(color: .black), at: Coordinate(rank: .one, file: .B))
        board.create(Pawn(color: .black), at: Coordinate(rank: .one, file: .C))
        board.create(Pawn(color: .black), at: Coordinate(rank: .two, file: .A))
        board.create(Pawn(color: .white), at: Coordinate(rank: .two, file: .B))
        let results = board.calculateScore()
        
        XCTAssertEqual(4, results.black)
        XCTAssertEqual(1, results.white)
    }
}
