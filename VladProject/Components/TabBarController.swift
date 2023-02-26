//
//  TabBarController.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.02.2023.
//

import Foundation

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let movieListViewController = MovieListViewController()
        movieListViewController.title = "Movies"
        movieListViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Ico_Compass"), selectedImage: nil)
        let moviesView = UINavigationController.init(rootViewController: movieListViewController)
        
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Profile"
        profileViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Ico_Profile"), selectedImage: nil)
        
        let profileView = UINavigationController.init(rootViewController: profileViewController)
        
        viewControllers = [moviesView, profileView]
    }
}


