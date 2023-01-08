//
//  ViewController.swift
//  VladProject
//
//  Created by Orlov Maxim on 27.12.2022.
//

import UIKit

class ListMoviesViewController: UIViewController {
    
    let select = SelectButton()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        addSubviews()
        configureConstraints()
        setupStyles()
    }
    
    private func addSubviews() {
        view.addSubview(select)
    }
    
    private func configureConstraints() {
        select.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            select.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            select.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupStyles() {
        view.backgroundColor = .blue
    }
    
}

