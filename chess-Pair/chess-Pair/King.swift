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
}

enum Rank {
    
}

class Rank: Int {
    
}

enum File {
    
}

class File {
    
}

struct Position: Equatable {
    let rank: Rank
    let file: File
    
    static func == (lhs: Position, rhs: Position) -> Bool {
        lhs.rank == rhs.rank && lhs.file == rhs.file
    }
}

class King: Equatable {
    let color: Color
    let position: (Rank, File)
    
    func isMovablePosition(to: (Rank, File)) -> Bool {
        return true
    }
    
    static func == (lhs: King, rhs: King) -> Bool {
        lhs.color == rhs.color && lhs.position == rhs.position
    }
}
