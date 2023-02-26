//
//  SwitchButton.swift
//  VladProject
//
//  Created by Vladislav Kitov on 08.01.2023.
//

import UIKit

class IconButton: UIButton {
    
    // MARK: - Struct

//    struct SwitchButtonViewModel {
//
//         enum View: String {
//             case ToTile = "Ico_Tile"
//             case ToList = "Ico_List"
//         }
//
//    }
    
    
    // MARK: - Propetrties
    
    let iconView = UIImageView()
    private let customBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    
    // MARK: - LifeCycle
    
    init(setIcon: String) {
        super.init(frame: .zero)
        iconView.image = UIImage(named: setIcon)
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
        
        [customBlurEffectView, iconView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 56),
            self.widthAnchor.constraint(equalToConstant: 56),
            
            customBlurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customBlurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customBlurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customBlurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            iconButton.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
//            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            
        ])
    }
    
    private func configureStyles() {
//        self.backgroundColor = Colors.primarySurfaceColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        iconView.tintColor = Colors.primaryTextOnSurfaceColor
        
        customBlurEffectView.isUserInteractionEnabled = false
        self.addTarget(self, action: #selector(animateDecrease), for: .touchDown)
        self.addTarget(self, action: #selector(animateIncrease), for: .touchUpInside)
    }
    
    @objc func animateDecrease() {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
//        generator.impactOccurred()
    }
    
    @objc func animateIncrease() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity
        }
        generator.impactOccurred()
    }
}

