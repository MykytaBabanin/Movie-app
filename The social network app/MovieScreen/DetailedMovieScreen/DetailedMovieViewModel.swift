//
//  DetailedMovieViewModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 06.12.2022.
//

import Foundation

class DetailedMovieViewModel {
    let movies: [MovieData]
    let indexPath: IndexPath
    
    init(movies: [MovieData], indexPath: IndexPath) {
        self.movies = movies
        self.indexPath = indexPath
    }
    
}
