//
//  King.swift
//  chess-Pair
//
//  Created by Grizzly.bear on 2022/06/23.
//

import Foundation

enum Color {
    case black
    case white
    
    var firstPosition : Position {
        switch self {
        case .black:
            return Position(rank: 8, file: .d)
        case .white:
            return Position(rank: 1, file: .d)
        }
    }
}

enum File: Int {
    case a = 0
    case b
    case c
    case d
    case e
    case f
    case g
    case h
}

struct Position: Equatable {
    let rank: Int
    let file: File
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        lhs.rank == rhs.rank && lhs.file.rawValue == rhs.file.rawValue
    }
}

enum Direction {
    case up
    case left
    case down
    case right
    // 대각선
    case upLeft
    case upRight
    case downLeft
    case downRight
}


class King: Equatable {
    let color: Color
    let position: Position
    
    init(color: Color, position: Position) {
        self.color = color
        self.position = position
    }
    
    func isMovable(rank: Int, file: File?) -> Bool {
        return (rank >= 0 && rank <= 8) && file != nil
    }
    
    // 이동 가능 여부 체크 함수
    func isMovable(direction: Direction) -> Bool {
        var file: File?
        var rank = 0
        
        switch direction {
        case .up:
            rank = rank - 1
        case .left:
            file = File(rawValue: self.position.file.rawValue - 1)
        case .down:
            rank = rank + 1
        case .right:
            file = File(rawValue: self.position.file.rawValue + 1)
        case .upLeft:
            rank = rank - 1
            file = File(rawValue: self.position.file.rawValue - 1)
        case .upRight:
            rank = rank - 1
            file = File(rawValue: self.position.file.rawValue + 1)
        case .downLeft:
            rank = rank + 1
            file = File(rawValue: self.position.file.rawValue - 1)
        case .downRight:
            rank = rank + 1
            file = File(rawValue: self.position.file.rawValue + 1)
        }
        
        return isMovable(rank: rank, file: file)
    }
    
    static func == (lhs: King, rhs: King) -> Bool {
        lhs.color == rhs.color && lhs.position == rhs.position
    }
    
    // 초기 위치 가능 여부 판단 함수
    func isMakable(position: Position) -> Bool {
        self.color.firstPosition == position
    }
}
