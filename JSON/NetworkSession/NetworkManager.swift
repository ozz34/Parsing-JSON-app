//
//  NetworkManager.swift
//  JSON
//
//  Created by Иван Худяков on 22.09.2022.
//

import Foundation

enum Link: String {
    case imageURL = "https://u-stena.ru/upload/iblock/8c2/8c2f36e88e65de30b8712b772cdf134a.jpg"
    case allPersonage = "https://rickandmortyapi.com/api/character"
    case gordonURL = "https://rickandmortyapi.com/api/character/149"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch <T: Decodable>(dataType: T.Type,
                              from url: String?,
                              completion: @escaping (Result <(T), NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return }

        URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
