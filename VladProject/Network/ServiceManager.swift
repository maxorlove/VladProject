//
//  ServiceManager.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

//class ServiceManager {
//
//    public static let shared: ServiceManager = ServiceManager()
//
//    public var baseURL: String = "https://rickandmortyapi.com/"
//}
//
//extension ServiceManager {
//
//    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) -> URLSessionDataTask {
//
//        let task = URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            guard
//                let data = data,
//                  let decodedModel = try? decoder.decode(T.self, from: data) else {
//                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
//
//                completion(.failure(error))
//                return
//            }
//
//            completion(.success(decodedModel))
//        }
//        task.resume()
//        return task
//    }
//
//}


class ServiceManager {

    public static let shared: ServiceManager = ServiceManager()

    public var baseURL: String = "https://api.themoviedb.org/3/"
}

extension ServiceManager {

    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) -> URLSessionDataTask {

        let task = URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard
                let data = data,
                  let decodedModel = try? decoder.decode(T.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)

                completion(.failure(error))
                return
            }

            completion(.success(decodedModel))
        }
        task.resume()
        return task
    }
    
}
