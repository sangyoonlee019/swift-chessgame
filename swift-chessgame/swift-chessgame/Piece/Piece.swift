//
//  Piece.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/20.
//

import Foundation

enum PieceKind {
    case pawn
    case bishop
    case rook
    case knight
    case queen
    
    var score: Int {
        switch self {
        case .pawn: return 1
        case .bishop, .knight: return 3
        case .rook: return 5
        case .queen: return 9
        }
    }
    
    var descriptions: (black: String, white: String) {
        switch self {
        case .pawn: return ("♟", "♙")
        case .bishop: return ("♝", "♗")
        case .rook: return ("♜", "♖")
        case .knight: return ("♞", "♘")
        case .queen: return ("♛", "♕")
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
    func candidates(from position: Coordinate) -> [Candidate]
}

extension Piece {
    var description: String {
        switch self.color {
        case .black: return self.kind.descriptions.black
        case .white: return self.kind.descriptions.white
        }
    }
}
