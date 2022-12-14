//
//  Repository.swift
//  The social network app
//
//  Created by Mykyta Babanin on 07.11.2022.
//

import Foundation

struct MovieData: Codable {
    var id: Int
    var thumbnail: String
    var imageLink: String
    var title: String
    var iMDB: String
    var description: String
    var trailerLink: String
    var catagory: Catagory
    var isFeaturedMovie: Bool
}

enum Catagory: String, CaseIterable, Codable, Hashable {
    case marvel = "Marvel"
    case dc = "DC"
    case actionAdventure = "Action and adventure"
}

final class Repository {
    private let apiClient: APIClient!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getMoviesFromURL(title: String,
                          _ completion: @escaping ((Result<MovieData>) -> Void)) {
        if let url = URL(string: "http://www.omdbapi.com/?t=\(title)&apikey=1701ebc0") {
            let resource = Resource(url: url)
            apiClient.load(resource) { (result) in
                switch result {
                case .success(let data):
                    do {
                        let items = try JSONDecoder().decode(MovieData.self, from: data)
                        completion(.success(items))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getMovies() -> [MovieData] {
        return apiClient.load("MovieData.json")
    }
}
