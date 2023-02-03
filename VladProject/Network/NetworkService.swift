//
//  NetworkService.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

//protocol NetworkService {
//    func allCharacters(page: Int, completion: @escaping(Result<AllCharactersResponse, ErrorModel>) -> Void) -> URLSessionDataTask
//}
//
//class NetworkServiceImpl: NetworkService {
//
//    func allCharacters(page: Int, completion: @escaping(Result<AllCharactersResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
//        let request = ServiceManager.shared.sendRequest(request: AllCharatersRequest(page: page), completion: completion)
//        return request
//    }
//
//}


protocol NetworkService {
    func allPopularMovies(page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask
}

class NetworkServiceImpl: NetworkService {

    func allPopularMovies(page: Int, completion: @escaping(Result<AllMoviesResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: AllMoviesRequest(sort: .popular, page: page), completion: completion)
        return request
    }

}
