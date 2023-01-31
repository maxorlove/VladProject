//
//  AllCharactersResponse.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

struct AllCharactersResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
}

struct Info: Codable {
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "pages"
    }
    
}
