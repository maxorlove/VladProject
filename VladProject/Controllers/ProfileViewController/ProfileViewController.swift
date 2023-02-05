//
//  ProfileViewController.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = .white
        
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = AttributedFontStyle.largeFont
    }
    
}
