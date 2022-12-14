//
//  NetworkManager.swift
//  The social network app
//
//  Created by Mykyta Babanin on 07.11.2022.
//

import Foundation

struct Resource {
    let url: URL
    let method: String = "GET"
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIClientError: Error {
    case noData
}

extension URLRequest {
    init(_ resource: Resource) {
        self.init(url: resource.url)
        self.httpMethod = resource.method
    }
}

final class APIClient {
    func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                result(.failure(APIClientError.noData))
                return
            }
            
            if let error = error {
                result(.failure(error))
                return
            }
            
            result(.success(data))
        }
        task.resume()
    }

    func load<T:Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}



//1701ebc0
