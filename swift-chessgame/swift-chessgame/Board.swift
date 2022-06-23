//
//  Board.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/20.
//

import Foundation

protocol BoardProtocol {
    func initialize()
    
    // Requirement1 print current score
    func printCurrentScore()
    
    // Requirement2 get current board state with String
    func display() -> [String]
    
    // Requirement3 create piece on board at certain position
    func create(_ piece: Piece, at position: Coordinate)
    
    // Requirement4 move piece on board
    func move(fromPosition: Coordinate, toPosition: Coordinate) -> Bool
}


final class Board: BoardProtocol {
    
    private var boardInfo: [Coordinate : Piece] = [:]
    
    func initialize() {
        Coordinate.files.forEach { file in
            let position = Coordinate(rank: .one, file: file)
            self.create(Pawn(color: .black), at: position)
        }
        
        Coordinate.files.forEach { file in
            let position = Coordinate(rank: .seven, file: file)
            self.create(Pawn(color: .white), at: position)
        }
        
        self.create(Bishop(color: .black), at: Coordinate(rank: .one, file: .C))
        self.create(Bishop(color: .black), at: Coordinate(rank: .one, file: .F))
        self.create(Bishop(color: .white), at: Coordinate(rank: .eight, file: .C))
        self.create(Bishop(color: .white), at: Coordinate(rank: .eight, file: .F))
        
        self.create(Rook(color: .black), at: Coordinate(rank: .one, file: .A))
        self.create(Rook(color: .black), at: Coordinate(rank: .one, file: .H))
        self.create(Rook(color: .white), at: Coordinate(rank: .eight, file: .A))
        self.create(Rook(color: .white), at: Coordinate(rank: .eight, file: .H))
        
        self.create(Knight(color: .black), at: Coordinate(rank: .one, file: .B))
        self.create(Knight(color: .black), at: Coordinate(rank: .one, file: .G))
        self.create(Knight(color: .white), at: Coordinate(rank: .eight, file: .B))
        self.create(Knight(color: .white), at: Coordinate(rank: .eight, file: .G))
        
        self.create(Queen(color: .black), at: Coordinate(rank: .one, file: .E))
        self.create(Queen(color: .white), at: Coordinate(rank: .eight, file: .E))
    }
    
    // MARK: - Requirement1 print current score
    func printCurrentScore() {
        let scores = calculateScore()
        print(scores.black, scores.white)
    }
    
    func calculateScore() -> (black: Int, white: Int) {
        var blackScore: Int = 0
        var whiteScore: Int = 0
        
        self.boardInfo.values.forEach { piece in
            let score = piece.kind.score
            if piece.color == .black {
                blackScore += score
            } else {
                whiteScore += score
            }
        }
        
        return (blackScore, whiteScore)
    }
    
    // MARK: - Requirement2 get current board state with String
    func display() -> [String] {
        var wholeDescription: [String] = []
        Coordinate.ranks.forEach { rank in
            var lineDescription = ""
            Coordinate.files.forEach { file in
                let coordinate = Coordinate(rank: rank, file: file)
                let descripiton = boardInfo[coordinate]?.description ?? "."
                lineDescription += descripiton
            }
            wholeDescription.append(lineDescription)
        }
        
        return wholeDescription
    }
    
    // MARK: - Requirement3 create piece on board at certain position
    func create(_ piece: Piece, at position: Coordinate) {
        boardInfo[position] = piece
    }
    
    // MARK: - Requirement4 move piece on board
    func move(fromPosition: Coordinate, toPosition: Coordinate) -> Bool {
        guard let fromPiece = boardInfo[fromPosition] else {
            return false
        }
        
        let vaildCandidate = fromPiece
            .candidates(from: fromPosition)
            .first(where: { [weak self] candidate in
                guard let self = self else { return false }
                if candidate.destination == toPosition {
                    if let transit = candidate.transit {
                        return self.boardInfo[transit] == nil
                    } else {
                        return true
                    }
                } else {
                    return false
                }
            })
        
        if vaildCandidate == nil {
            return false
        }
    
        let movePiece = {
            self.boardInfo[fromPosition] = nil
            self.boardInfo[toPosition] = fromPiece
        }
        
        if let toPiece = boardInfo[toPosition] {
            if fromPiece.color == toPiece.color {
                return false
            } else {
                movePiece()
            }
        } else {
            movePiece()
        }
        
        return true
    }
}

extension Board {
    var pieces: [Piece] {
        guard let pieces = Array(self.boardInfo.values) as? [Piece] else {
            return []
        }
        return pieces
    }
    
    var whitePieces: [Piece] {
        self.pieces.filter { $0.color == .white }
    }
    
    var blackPieces: [Piece] {
        self.pieces.filter { $0.color == .black }
    }
}



