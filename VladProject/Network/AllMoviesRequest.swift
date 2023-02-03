//
//  AllCharactersRequest.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

//class AllCharatersRequest: RequestModel {
//
//    private var page: Int
//
//    init(page: Int) {
//        self.page = page
//    }
//
//    override var path: String {
//        return "api/character"
//    }
//
//    override var parameters: [String : Any?] {
//        return [
//            "page": page
//        ]
//    }
//
//    override var method: RequestHTTPMethod {
//        return .get
//    }
//}

enum Sorting {
    case popular
    case latest
    case now_playing
    case top_rated
    case upcoming
}

class AllMoviesRequest: RequestModel {
    
    private var sort: Sorting
    private let key: String = "bc9b269898d88d2847b3d4469cb0aa38"
    private let language: String = "en-US"
    private var page: Int
    
    
    
    init(sort: Sorting, page: Int) {
        self.sort = .popular
        self.page = page
    }

    override var path: String {
//        return "movie/\(sort)"
        return "movie/\(sort)?api_key=\(key)&language=\(language)&"
    }

    override var parameters: [String : Any?] {
        return [
//            "api_key": key,
//            "language": language,
            "page": page,
        ]
    }

    override var method: RequestHTTPMethod {
        return .get
    }
}

//https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=bc9b269898d88d2847b3d4469cb0aa38&page=1&
