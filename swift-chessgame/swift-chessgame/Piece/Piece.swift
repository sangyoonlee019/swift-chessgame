//
//  Piece.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/20.
//

import Foundation

enum PieceKind {
    case pawn
    
    var score: Int {
        switch self {
        case .pawn: return 1
        }
    }
    
    var descriptions: (black: String, white: String) {
        switch self {
        case .pawn: return ("♟", "♙")
        }
    }
    
    var directions: (black: Direction, white: Direction) {
        switch self {
        case .pawn: return (.down, .up)
        }
    }

}

enum PieceColor {
    case black, white
}

protocol Piece {
    var color: PieceColor { get }
    var kind: PieceKind { get }
    
    // Requirement7 piece provide movable position based on current position
    func candidates(from position: Coordinate) -> [Coordinate]
}

extension Piece {
    var description: String {
        switch self.color {
        case .black: return self.kind.descriptions.black
        case .white: return self.kind.descriptions.white
        }
    }
    
    var direction: Direction {
        switch self.color {
        case .black: return self.kind.directions.black
        case .white: return self.kind.directions.white
        }
    }
}
