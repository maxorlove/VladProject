//
//  NetworkService.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

import Foundation

protocol NetworkService {
    func allCharacters(page: Int, completion: @escaping(Result<AllCharactersResponse, ErrorModel>) -> Void) -> URLSessionDataTask
}

class NetworkServiceImpl: NetworkService {

    func allCharacters(page: Int, completion: @escaping(Result<AllCharactersResponse, ErrorModel>) -> Void) -> URLSessionDataTask {
        let request = ServiceManager.shared.sendRequest(request: AllCharatersRequest(page: page), completion: completion)
        return request
    }

}
