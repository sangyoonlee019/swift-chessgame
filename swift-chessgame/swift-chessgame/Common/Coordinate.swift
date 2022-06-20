//
//  Coordinate.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/20.
//

import Foundation

enum Direction {
    case up
    case down
    case left
    case right
    
    var unit: (rank: Int, file: Int) {
        switch self {
        case .up:    return (-1, 0)
        case .down:  return (1, 0)
        case .left:  return (0, -1)
        case .right: return (0, 1)
        }
    }
}

struct Coordinate: Hashable {
    static let ranks: [Rank] = Rank.allCases
    static let files: [File] = File.allCases
    
    let rank: Rank
    let file: File
    
    enum Rank: Int, CaseIterable {
        case one = 1
        case two, three, four, five, six, seven, eight
    }

    enum File: Int, CaseIterable {
        case A = 1
        case B, C, D, E, F, G, H
    }

    func move(count: Int, direction: Direction) -> Coordinate? {
        let dRank = direction.unit.rank * count
        let dFile = direction.unit.file * count
        
        guard let newRank = Rank(rawValue: self.rank.rawValue + dRank),
              let newFile = File(rawValue: self.file.rawValue + dFile) else {
            return nil
        }
        return Coordinate(rank: newRank, file: newFile)
    }
}
