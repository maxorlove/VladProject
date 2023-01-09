//
//  SwitchButton.swift
//  VladProject
//
//  Created by Vladislav Kitov on 08.01.2023.
//

import UIKit

class SwitchButton: UIButton {
    
    // MARK: - Struct

    struct SwitchButtonViewModel {

         enum View: String {
             case IsTile = "Ico_Tile"
             case IsList = "Ico_List"
         }
        
    }
    
    
    // MARK: - Propetrties
    
    let iconButton = UIImageView()
    
    
    // MARK: - LifeCycle
    
    init(setIcon: SwitchButtonViewModel.View) {
        super.init(frame: .zero)
        iconButton.image = UIImage(named: SwitchButtonViewModel.View.IsTile.rawValue)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Methods
    
    private func configureView() {
        addSubviews()
        configureConstraints()
        configureStyles()
    }
    
    private func addSubviews() {
        addSubview(iconButton)
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48),
            self.widthAnchor.constraint(equalToConstant: 48),
            iconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconButton.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            iconButton.heightAnchor.constraint(equalToConstant: 24),
            iconButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func configureStyles() {
        self.backgroundColor = Colors.primarySurfaceColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        
        iconButton.tintColor = Colors.primaryTextOnSurfaceColor
        
        
        
        
    }
    
}
