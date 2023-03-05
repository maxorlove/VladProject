//
//  UserModel.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.03.2023.
//

import UIKit

enum DataProfileKeys: String {
    case userName = "userName"
    case emailAddress = "emailAddress"
    case userPhoto = "userPhoto"
}

class Profile {
    var name: String
    var email: String
    var photo: UIImage?

    init(
        name: String?,
        email: String?,
        photo: UIImage?
    ){
        self.name = name ?? "Unknown name"
        self.email = email ?? "Enter email"
        self.photo = photo
    }
}
