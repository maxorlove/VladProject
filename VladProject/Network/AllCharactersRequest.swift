//
//  AllCharactersRequest.swift
//  VladProject
//
//  Created by Vladislav Kitov on 31.01.2023.
//

import Foundation

class AllCharatersRequest: RequestModel {

    private var page: Int

    init(page: Int) {
        self.page = page
    }

    override var path: String {
        return "api/character"
    }

    override var parameters: [String : Any?] {
        return [
            "page": page
        ]
    }

    override var method: RequestHTTPMethod {
        return .get
    }
}
