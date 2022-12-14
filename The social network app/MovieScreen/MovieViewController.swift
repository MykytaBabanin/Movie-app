//
//  MovieViewController.swift
//  The social network app
//
//  Created by Mykyta Babanin on 01.11.2022.
//

import Foundation
import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    weak var coordinator: BaseCoordinator?
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel: MoviesListViewModel?
    
    private let cellId = "CellId"
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupStyle()
    }
    
    private func setupCollectionView() {
        collectionView.register(MoviePosterView.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupStyle() {
        view.backgroundColor = .white
        makeGradientColor()
    }
    
    private func makeGradientColor()  {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor.white
        let colorCenter = UIColor.black
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom, colorCenter]
        gradientLayer.locations = [0.0, 1.0, 1.0]
        gradientLayer.frame = backgroundView.bounds
        
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviePosterView
        cell.setup(model: viewModel?.items ?? [], indexPath: indexPath)
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = viewModel?.items else { return }
        viewModel?.moveToDetailedPage(with: indexPath, movies: movies)
    }
}
