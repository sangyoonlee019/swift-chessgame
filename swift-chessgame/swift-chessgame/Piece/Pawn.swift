//
//  Pawn.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/20.
//

import Foundation

struct Pawn: Piece {
    let color: PieceColor
    let kind: PieceKind = .pawn
    
    func candidates(from position: Coordinate) -> [Coordinate] {
        var candidates: [Coordinate] = []
        if let candidate = position.move(count: 1, direction: self.direction) {
            candidates.append(candidate)
        }
        return candidates
    }
}
