//
//  Personage.swift
//  JSON
//
//  Created by Иван Худяков on 19.09.2022.
//

import Foundation

struct Personage: Decodable {
    
    let name: String
    let status: String
    let image: String
    let location: [Location]
}

struct Location: Decodable {
    let name: String
    let url: String
}
