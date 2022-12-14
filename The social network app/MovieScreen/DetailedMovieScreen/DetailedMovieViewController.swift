//
//  DetailedMovieViewController.swift
//  The social network app
//
//  Created by Mykyta Babanin on 05.12.2022.
//

import Foundation
import UIKit

protocol Handler {
    associatedtype Input
    func start(input: Input) -> Bool
}

class DetailedMovieViewController: UIViewController, Handler {
    typealias Input = String
    
    weak var coordinator: BaseCoordinator?
    private let viewModel: DetailedMovieViewModel
    
    @IBOutlet weak var detailedImageView: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var moviePlot: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var firstGenreLabel: UILabel!
    @IBOutlet weak var secondGenreLabel: UILabel!
    
    init(viewModel: DetailedMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupStyle()
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(input: Input) -> Bool {
        return true
    }
    
    func setup() {
        guard let url = URL(string: viewModel.movies[viewModel.indexPath.row].imageLink) else { return }
        detailedImageView.kf.setImage(with: url)
        movieRating.text = viewModel.movies[viewModel.indexPath.row].iMDB
    }
    
    func setupStyle() {
        detailView.layer.cornerRadius = 45
    }
}

