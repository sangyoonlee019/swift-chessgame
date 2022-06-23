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
    
    var up: Position? {
        guard rank - 1 > 0 else {
            return nil
        }
        return Position(rank: rank - 1, file: file)
    }
    
    var left: Position? {
        guard let file = File(rawValue: self.file.rawValue - 1) else {
            return nil
        }
        return Position(rank: self.rank, file: file)
    }
    
    var down: Position? {
        guard rank + 1 < 9 else {
            return nil
        }
        return Position(rank: rank + 1, file: file)
    }
    
    var right: Position? {
        guard let file = File(rawValue: self.file.rawValue + 1) else {
            return nil
        }
        return Position(rank: rank, file: file)
    }
    
    var upLeft: Position? {
        return self.up?.left
    }
    
    var upRight: Position? {
        return self.up?.right
    }
    
    var downLeft: Position? {
        return self.down?.left
    }
    
    var downRight: Position? {
        return self.down?.right
    }
}

class King: Equatable {
    let color: Color
    let position: Position
    
    init(color: Color) {
        self.color = color
        self.position = self.color.firstPosition
    }
    
    func isMovable(rank: Int, file: File?) -> Bool {
        return (rank >= 0 && rank <= 8) && file != nil
    }
    
    static func == (lhs: King, rhs: King) -> Bool {
        lhs.color == rhs.color && lhs.position == rhs.position
    }
    
    // 초기 위치 가능 여부 판단 함수
    func isMakable(position: Position) -> Bool {
        self.color.firstPosition == position
    }
}
