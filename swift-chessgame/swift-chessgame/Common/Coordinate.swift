//
//  Coordinate.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/20.
//

import Foundation

struct Unit {
    let rank: Int
    let file: Int
    
    static func +(lhs: Unit, rhs: Unit) -> Unit {
        Unit(rank: lhs.rank + rhs.rank, file: lhs.file + rhs.file)
    }
}

enum Direction {
    case up
    case down
    case left
    case right
    
    var unit: Unit {
        switch self {
        case .up:    return Unit(rank: -1, file: 0)
        case .down:  return Unit(rank: 1, file: 0)
        case .left:  return Unit(rank: 0, file: -1)
        case .right: return Unit(rank: 0, file: 1)
        }
    }
}

struct Coordinate: Hashable {
    static let ranks: [Rank] = Rank.allCases
    static let files: [File] = File.allCases
    
    static var maxColumn: Int { File.H.rawValue }
    static var maxRow: Int { Rank.eight.rawValue }
    
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
    
    func move(count: Int, unit: Unit) -> Coordinate? {
        guard let newRank = Rank(rawValue: self.rank.rawValue + unit.rank * count),
              let newFile = File(rawValue: self.file.rawValue + unit.file * count) else {
            return nil
        }
        return Coordinate(rank: newRank, file: newFile)
    }
}

struct Candidate {
    let destination: Coordinate
    let transits: [Coordinate]?
}

extension Candidate {
    init(destination: Coordinate) {
        self.init(destination: destination, transits: nil)
    }
}
