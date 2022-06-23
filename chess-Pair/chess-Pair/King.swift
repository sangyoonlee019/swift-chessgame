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
            return Position(rank: .8, file: .d)
        case .white:
            return Position(rank: .1, file: .d)
        }
    }
}

enum Rank: Int {
    case 1 = 0
    case 2
    case 3
    case 4
    case 5
    case 6
    case 7
    case 8
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
    let rank: Rank
    let file: File
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        lhs.rank.rawValue == rhs.rank.rawValue && lhs.file.rawValue == rhs.file.rawValue
    }
}

enum Direction {
    case top
    case left
    case bottom
    case right
    // 대각선
    case topLeft
    case topRight
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
    
    func isMovable(position: Position) -> Bool {
        return true
    }
    
    // 이동 가능 여부 체크 함수
    func isMovable(direction: Direction) -> Bool {
        switch direction {
        case .top:
            return isMovable(position: Position(rank: position.rank - 1, file: position.file))
        case .left:
            return isMovable(position: Position(rank: position.rank , file: position.file - 1))
        case .bottom:
            return isMovable(position: Position(rank: position.rank + 1, file: position.file))
        case .right:
            return isMovable(position: Position(rank: position.rank, file: position.file + 1))
        case .topLeft:
            return isMovable(position: Position(rank: position.rank - 1, file: position.file - 1))
        case .topRight:
            return isMovable(position: Position(rank: position.rank - 1, file: position.file + 1))
        case .downLeft:
            return isMovable(position: Position(rank: position.rank + 1, file: position.file - 1))
        case .downRight:
            return isMovable(position: Position(rank: position.rank +1, file: position.file +1))
        }
        return true
    }
    
    static func == (lhs: King, rhs: King) -> Bool {
        lhs.color == rhs.color && lhs.position == rhs.position
    }
    
    // 초기 위치 가능 여부 판단 함수
    func isMakable(position: Position) -> Bool {
        self.color.firstPosition == position
    }
}
