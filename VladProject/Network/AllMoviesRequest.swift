//
//  AllCharactersRequest.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

//struct TypeSorting {
//
//     enum Sort: String {
//         case popular = "popular"
//         case latest = "latest"
//         case nowPlaying = "now_playing"
//         case topRated = "top_rated"
//         case upcoming = "upcoming"
//     }
//}


class AllMoviesRequest: RequestModel {
    
    private var sort: String
    private let key: String = "bc9b269898d88d2847b3d4469cb0aa38"
    private let language: String = "en-US"
    private var page: Int
    
    
    
    init(sort: String, page: Int) {
        self.sort = sort
        self.page = page
    }

    override var path: String {
        return "movie/\(sort)"
    }

    override var parameters: [String : Any?] {
        return [
            "api_key": key,
            "language": language,
            "page": page,
        ]
    }

    
    
    override var method: RequestHTTPMethod {
        return .get
    }
}
