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
    func move(fromPosition: Coordinate, toPosition: Coordinate)
    func canMove(fromPosition: Coordinate, toPosition: Coordinate) -> Bool
    
    // Requirement2.1 get piece at position
    func piece(at position: Coordinate) -> Piece?
    
    // Requirement2.2 get valid candidate postions of piece
    func movablePositions(of piece: Piece, from position: Coordinate) -> [Coordinate]
}


final class Board: BoardProtocol {
    
    private var boardInfo: [Coordinate : Piece] = [:]
    
    func initialize() {
        Coordinate.files.forEach { file in
            let position = Coordinate(rank: .two, file: file)
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
        print("white:", scores.white, "black:", scores.black)
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
    func move(fromPosition: Coordinate, toPosition: Coordinate) {
        guard let fromPiece = boardInfo[fromPosition] else {
            return
        }
        
        if canMove(fromPosition: fromPosition, toPosition: toPosition) {
            let killed = self.boardInfo[toPosition] != nil
            self.boardInfo[fromPosition] = nil
            self.boardInfo[toPosition] = fromPiece
            killed ? self.printCurrentScore() : nil
        }
    }
    
    func canMove(fromPosition: Coordinate, toPosition: Coordinate) -> Bool {
        guard let fromPiece = boardInfo[fromPosition] else {
            return false
        }
        
        let vaildCandidate = fromPiece
            .candidates(from: fromPosition)
            .first(where: { [weak self] candidate in
                guard let self = self else { return false }
                if candidate.destination == toPosition {
                    if let transits = candidate.transits {
                        let transitIsEmpty = transits.reduce(true) {
                            $0 && self.boardInfo[$1] == nil
                        }
                        return transitIsEmpty
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
    
        if let toPiece = boardInfo[toPosition] {
            return fromPiece.color != toPiece.color
        } else {
            return true
        }
    }
    
    // MARK: - Requirement2.1 get piece at Position
    func piece(at position: Coordinate) -> Piece? {
        return boardInfo[position]
    }
    
    // MARK: - Requirement2.2 get candidate postions of piece
    func movablePositions(of piece: Piece, from position: Coordinate) -> [Coordinate] {
        piece
            .candidates(from: position)
            .map { candidate in candidate.destination }
            .filter { [weak self] destination in
                guard let self = self else { return false }
                return self.canMove(fromPosition: position, toPosition: destination)
            }
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



