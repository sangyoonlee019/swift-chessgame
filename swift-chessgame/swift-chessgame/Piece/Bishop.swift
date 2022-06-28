//
//  Bishop.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/23.
//

import Foundation

struct Bishop: Piece {
    let color: PieceColor
    let kind: PieceKind = .bishop
    
    func candidates(from position: Coordinate) -> [Candidate] {
        var candidates: [Candidate] = []
        let units: [Unit] = [
            Direction.up.unit + Direction.left.unit,
            Direction.up.unit + Direction.right.unit,
            Direction.down.unit + Direction.left.unit,
            Direction.down.unit + Direction.right.unit
        ]
        
        units.forEach { unit in
            var transit: [Coordinate] = []
            for count in 1... {
                if let finalPosition = position.move(count: count, unit: unit) {
                    candidates.append(Candidate(destination: finalPosition, transits: transit))
                    transit.append(finalPosition)
                } else {
                    break
                }
            }
        }
        
        return candidates
    }
}
