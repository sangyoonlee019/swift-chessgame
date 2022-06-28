//
//  PieceView.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/27.
//

import Foundation
import UIKit
import SnapKit

class PieceCell: UICollectionViewCell {
    static var height: CGFloat { 45 }
    static var reuseIdentifier: String { "PieceCell" }
    
    // MARK: - UI
    let pieceLabel: UILabel = {
        let pieceLabel = UILabel()
        pieceLabel.font = .systemFont(ofSize: 30, weight: .bold)
        pieceLabel.textColor = .black
        return pieceLabel
    }()
    
    
    // MARK: - Properties
    var peice: Piece? {
        didSet {
            guard let peice = self.peice else { return }
            self.pieceLabel.text = peice.description
        }
    }
    
    var borderActivated: Bool = false {
        didSet {
            self.layer.borderWidth = self.borderActivated ? 1 : 0
        }
    }
    
    var pieceSelected: Bool = false {
        didSet {
            self.layer.borderWidth = self.pieceSelected ? 2 : 0
        }
    }
    
    
    // MARK: - Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
        self.applyStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        self.pieceLabel.text = ""
        self.borderActivated = false
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.pieceLabel)
        self.pieceLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func applyStyle() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
    }
}
