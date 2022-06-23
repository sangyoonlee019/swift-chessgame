//
//  Rook.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/23.
//

import Foundation

struct Rook: Piece {
    let color: PieceColor
    let kind: PieceKind = .rook
    
    func candidates(from position: Coordinate) -> [Candidate] {
        var candidates: [Candidate] = []
        let directions: [Direction] = [
            .up,
            .down,
            .left,
            .right
        ]
        
        directions.forEach { direction in
            for count in 1... {
                if let finalPosition = position.move(count: count, direction: direction) {
                    candidates.append(Candidate(destination: finalPosition))
                } else {
                    break
                }
            }
        }

        return candidates
    }
}
