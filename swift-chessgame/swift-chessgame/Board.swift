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
        
        let candidates = fromPiece.candidates(from: fromPosition)
        if candidates.isEmpty || !candidates.contains(toPosition) {
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



