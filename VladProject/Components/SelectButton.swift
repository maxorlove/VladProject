//
//  Select.swift
//  VladProject
//
//  Created by Vladislav Kitov on 08.01.2023.
//

import UIKit

class SelectButton: UIButton {
    
    // MARK: - Propetrties
    
    let labelButton = UILabel()
    let iconButton = UIImageView()
    
    
    // MARK: - LifeCycle
    
    init(setText: String) {
        super.init(frame: .zero)
        labelButton.text = setText.uppercased()
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
        addSubview(labelButton)
        addSubview(iconButton)
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        labelButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48),
//            self.widthAnchor.constraint(equalToConstant: 96),
            labelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            iconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconButton.leadingAnchor.constraint(equalTo: labelButton.trailingAnchor, constant: 8),
            iconButton.heightAnchor.constraint(equalToConstant: 24),
            iconButton.widthAnchor.constraint(equalToConstant: 24),
            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    private func configureStyles() {
        self.backgroundColor = Colors.primarySurfaceColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        labelButton.font = FontSize.actionFont
        labelButton.textColor = Colors.primaryTextOnSurfaceColor
        labelButton.textAlignment = .center
        iconButton.image = UIImage(named: "Ico_Chevron_Down")
        iconButton.tintColor = Colors.primaryTextOnSurfaceColor
        
        
        
        
    }
    
}
