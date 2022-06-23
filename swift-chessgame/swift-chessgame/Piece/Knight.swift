//
//  Knight.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/23.
//

import Foundation

struct Knight: Piece {
    let color: PieceColor
    let kind: PieceKind = .knight
    
    func candidates(from position: Coordinate) -> [Candidate] {
        var candidates: [Candidate] = []
        let units: [(first: Unit, second: Unit)] = [
            (Direction.up.unit, Direction.left.unit),
            (Direction.up.unit, Direction.right.unit),
            (Direction.down.unit, Direction.left.unit),
            (Direction.down.unit, Direction.right.unit)
        ]
        
        units.forEach { unit in
            if let firstPosition = position.move(count: 1, unit: unit.first),
               let finalPosition = firstPosition.move(count: 1, unit: unit.second) {
                candidates.append(Candidate(destination: finalPosition, transit: firstPosition))
            }
        }
        return candidates
    }
}
