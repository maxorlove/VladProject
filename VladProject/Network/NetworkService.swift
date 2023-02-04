//
//  NetworkService.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

protocol NetworkService {
    func allMovies(sort: String, page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask
}

class NetworkServiceImpl: NetworkService {

    func allMovies(sort: String, page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: AllMoviesRequest(sort: sort, page: page), completion: completion)
        return request
    }
}
