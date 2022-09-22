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

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Data) -> Void) {
        
        guard let url = URL(string: url ?? "") else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
