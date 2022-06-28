//
//  IndexPathExtensions.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/27.
//

import Foundation

extension IndexPath {
    var rank: Coordinate.Rank? {
        Coordinate.Rank(rawValue: self.item / Coordinate.maxRow + 1)
    }
    
    var file: Coordinate.File? {
        Coordinate.File(rawValue: self.item % Coordinate.maxColumn + 1)
    }
    
    var position: Coordinate? {
        guard let rank = rank,
              let file = file else {
            return nil
        }
        return Coordinate(rank: rank, file: file)
    }
}

extension Coordinate {
    var indexPath: IndexPath {
        return IndexPath(
            item: (self.rank.rawValue - 1) * Coordinate.maxRow + self.file.rawValue - 1,
            section: 0
        )
    }
}
