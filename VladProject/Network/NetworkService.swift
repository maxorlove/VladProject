//
//  NetworkService.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

protocol NetworkService {
    func allPopularMovies(sort: String, page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask
//    func allLatestMovies(page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask
}

class NetworkServiceImpl: NetworkService {

    func allPopularMovies(sort: String, page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        
        let defaultSort: String = sort
        
        let request = ServiceManager.shared.sendRequest(request: AllMoviesRequest(sort: defaultSort, page: page), completion: completion)
        return request
    }
    
//    func allLatestMovies(page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
//        let request = ServiceManager.shared.sendRequest(request: AllMoviesRequest(sort: .latest, page: page), completion: completion)
//        return request
//    }

}
