//
//  BoardView.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/27.
//

import UIKit
import SnapKit
import Foundation

protocol BoardControllable {
    var board: BoardProtocol { get }
    
    func select(position: Coordinate, in cell: PieceCell)
    func deselect()
    func move(fromPosition: Coordinate, toPosition: Coordinate)
    func endTurn()
}

class BoardView: UIView, BoardControllable, UICollectionViewDataSource, UICollectionViewDelegate {
    private var maxColumn: Int { Coordinate.maxColumn }
    private var maxRow: Int { Coordinate.maxRow }
    
    // MARK: - UI
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(PieceCell.self, forCellWithReuseIdentifier: PieceCell.reuseIdentifier)
        collectionView.collectionViewLayout = self.layout
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Properties
    let board: BoardProtocol
    var selectedPosition: Coordinate?
    var side: PieceColor = .white
    
    var feedbackGenerator: UIFeedbackGenerator?
    
    // MARK: - Initializing
    init(board: BoardProtocol) {
        self.board = board
        self.board.initialize()
        super.init(frame: .zero)
        self.setupViews()
        self.feedbackGenerator = UIFeedbackGenerator()
        self.feedbackGenerator?.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.collectionView.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    // MARK: - Layout
    var layout: UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1/8),
                    heightDimension: .estimated(PieceCell.height)
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(PieceCell.height)
                ),
                subitem: item,
                count: 8
            )
            group.interItemSpacing = .fixed(5)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 5
            return section
        }
    }
    
    // MARK: - Board Controll
    func select(position: Coordinate, in cell: PieceCell) {
        guard let piece = self.board.piece(at: position),
              piece.color == side else { return }
    
        cell.pieceSelected = true
        self.board
            .movablePositions(of: piece, from: position)
            .map { position in position.indexPath }
            .compactMap { [weak self] indexPath in
                self?.collectionView.cellForItem(at: indexPath) as? PieceCell
            }
            .forEach { pieceCell in
                pieceCell.borderActivated = true
            }
        self.selectedPosition = position
    }
    
    func deselect() {
        self.selectedPosition = nil
        self.collectionView.reloadData()
    }
    
    func move(fromPosition: Coordinate, toPosition: Coordinate) {
        self.board.move(fromPosition: fromPosition, toPosition: toPosition)
        self.collectionView.reloadData()
        self.endTurn()
    }
    
    func endTurn() {
        self.selectedPosition = nil
        self.side.turnEnd()
    }
    
    // MARK: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PieceCell,
              let position = indexPath.position else { return }

        if let selectedPosition = self.selectedPosition {
            if selectedPosition == position {
                self.deselect()
            } else if cell.borderActivated {
                self.move(fromPosition: selectedPosition, toPosition: position)
            }
        } else {
            self.select(position: position, in: cell)
        }
    }
    
    
    // MARK: - CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.maxRow * self.maxColumn
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PieceCell.reuseIdentifier, for: indexPath) as? PieceCell else {
            return UICollectionViewCell()
        }
    
        if let position = indexPath.position,
           let piece = self.board.piece(at: position)
        {
            cell.peice = piece
        }
        cell.borderActivated = false
        cell.pieceSelected = false
        return cell
    }
}
