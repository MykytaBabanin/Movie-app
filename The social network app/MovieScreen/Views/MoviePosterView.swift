//
//  MoviePosterView.swift
//  The social network app
//
//  Created by Mykyta Babanin on 03.11.2022.
//

import Foundation
import UIKit
import Kingfisher

class MoviePosterView: UICollectionViewCell, ControlSetup {
    
    private lazy var posterView = UIImageView()
    private lazy var runtimeLabel = UILabel()
    private lazy var nameLabel = UILabel()
    private lazy var genreLabel = UILabel()
    
    let cellId = "CellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        controlSetup()
        Test2().name()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupSubviews() {
        contentView.addSubviewAndDisableAutoResizing([posterView,
                                                     runtimeLabel,
                                                     nameLabel])
    }
    
    func setupAutoLayout() {
        NSLayoutConstraint.activate([
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.bottomAnchor.constraint(equalTo: runtimeLabel.topAnchor, constant: -10),
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            runtimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupStyle() {
        nameLabel.font = .systemFont(ofSize: 18)
        runtimeLabel.font = .systemFont(ofSize: 12)
        posterView.layer.cornerRadius = 20
        posterView.layer.masksToBounds = true
        nameLabel.numberOfLines = 0
    }
    
    func setup(model: [MovieData], indexPath: IndexPath) {
        guard let url = URL(string: model[indexPath.row].imageLink) else { return }
        posterView.kf.setImage(with: url)
        runtimeLabel.text = model[indexPath.row].thumbnail
        nameLabel.text = model[indexPath.row].title
    }
}


protocol Protocol1 {
    func name()
}

extension Protocol1 {
    func name() {
        print("dsadsadsa")
    }
}

class Test1: Protocol1 {
    func name() {
        print("dsafasf")
    }
}

class Test2: Test1 {
    override func name() {
        print("1")
    }
}


