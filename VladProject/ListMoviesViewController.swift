//
//  ViewController.swift
//  VladProject
//
//  Created by Orlov Maxim on 27.12.2022.
//

import UIKit

class ListMoviesViewController: UIViewController {
    
    let selectButton = SelectButton(setText: "Popular")
    let switchButton = SwitchButton(setIcon: .IsTile)
    let image = UIImageView()
    let sortStack = UIStackView()
    
    
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
        
        [image, sortStack, selectButton, switchButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
  
            sortStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sortStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            sortStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
//            sortStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 256),
            image.widthAnchor.constraint(equalToConstant: 170)
            
        ])
        
        sortStack.axis = NSLayoutConstraint.Axis.horizontal
        //sortStack.distribution = UIStackView.Distribution.fill
        sortStack.spacing = 8
        sortStack.alignment = UIStackView.Alignment.top
        
        sortStack.addArrangedSubview(selectButton)
        sortStack.addArrangedSubview(switchButton)
        
    }
    
    private func setupStyles() {
        view.backgroundColor = .blue
        image.image = UIImage(named: "Cover")
    }
    
}

