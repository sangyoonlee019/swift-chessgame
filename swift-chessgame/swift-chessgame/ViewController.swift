//
//  ViewController.swift
//  swift-chessgame
//
//  Created by 이상윤 on 2022/06/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let boardView: UIView = BoardView(board: Board())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(self.boardView)
        self.boardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

