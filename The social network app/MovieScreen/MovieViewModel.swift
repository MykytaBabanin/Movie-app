//
//  MovieViewModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 01.11.2022.
//

import Foundation
import Combine

enum MovieTitles: String {
    case Batman
    case Superman
    case Shrek
    case fantasticBeasts = "Fantastic+Beasts"
}

enum MovieActions {
    case pushDetailedViewController(indexPath: IndexPath, movies: [MovieData])
}

class MoviesListViewModel {
    typealias MovieActionCallback = (MovieActions) -> Void
    
    private let model: Repository?
    var items: [MovieData] = []
    var movieActionCallback: MovieActionCallback?
    
    init(model: Repository, movieActionCallback: @escaping MovieActionCallback) {
        self.model = model
        self.movieActionCallback = movieActionCallback
        getMovies()
    }
    
    func moveToDetailedPage(with indexPath: IndexPath, movies: [MovieData]) {
        movieActionCallback?(.pushDetailedViewController(indexPath: indexPath, movies: movies))
    }
    
    func getPosters(title: String) {
        model?.getMoviesFromURL(title: title) { [weak self] result in
            switch result {
            case .success(let data):
                self?.items.append(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovies() {
        items = (model?.getMovies())!
    }
}
