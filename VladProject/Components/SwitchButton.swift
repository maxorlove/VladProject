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
             case ToTile = "Ico_Tile"
             case ToList = "Ico_List"
         }
        
    }
    
    
    // MARK: - Propetrties
    
    let iconButton = UIImageView()
    private let customBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    
    // MARK: - LifeCycle
    
    init(setIcon: SwitchButtonViewModel.View) {
        super.init(frame: .zero)
        iconButton.image = UIImage(named: setIcon.rawValue)
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
        
        [customBlurEffectView, iconButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 48),
            self.widthAnchor.constraint(equalToConstant: 48),
            
            customBlurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customBlurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customBlurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customBlurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            
            iconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconButton.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            iconButton.heightAnchor.constraint(equalToConstant: 24),
            iconButton.widthAnchor.constraint(equalToConstant: 24),
            
        ])
    }
    
    private func configureStyles() {
//        self.backgroundColor = Colors.primarySurfaceColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        iconButton.tintColor = Colors.primaryTextOnSurfaceColor
        
        customBlurEffectView.isUserInteractionEnabled = false
        self.addTarget(self, action: #selector(animateDecrease), for: .touchDown)
        self.addTarget(self, action: #selector(animateIncrease), for: .touchUpInside)
    }
    
    @objc func animateDecrease() {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    @objc func animateIncrease() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity
        }
    }
}

