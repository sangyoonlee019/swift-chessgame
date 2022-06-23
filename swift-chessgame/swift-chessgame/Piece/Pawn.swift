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
    
    func candidates(from position: Coordinate) -> [Candidate] {
        var candidates: [Candidate] = []
        let direction: Direction = color == .black ? .down : .up
        if let finalPosition = position.move(count: 1, direction: direction) {
            candidates.append(Candidate(destination: finalPosition))
        }
        
        return candidates
    }
}
