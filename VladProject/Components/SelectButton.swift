//
//  Select.swift
//  VladProject
//
//  Created by Vladislav Kitov on 08.01.2023.
//

import UIKit

class SelectButton: UIButton {
    
    // MARK: - Propetrties
    
    var labelButton = UILabel()
    let iconButton = UIImageView()
    private let customBlurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - LifeCycle
    
    init(label: String) {
        super.init(frame: .zero)
        setLabel(labelText: label)
        //        labelButton.text = setText.uppercased()
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
        
        [customBlurEffectView, labelButton, iconButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 56),
            
            customBlurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            customBlurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            customBlurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            customBlurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            
            labelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            iconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconButton.leadingAnchor.constraint(equalTo: labelButton.trailingAnchor, constant: 8),
            iconButton.heightAnchor.constraint(equalToConstant: 24),
            iconButton.widthAnchor.constraint(equalToConstant: 24),
            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    func setLabel(labelText: String) {
        labelButton.text = labelText.uppercased()
    }
    
    private func configureStyles() {
        //        self.backgroundColor = Colors.primarySurfaceColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        labelButton.font = FontStyle.actionFont
        labelButton.textColor = Colors.primaryTextOnSurfaceColor
        labelButton.textAlignment = .center
        iconButton.image = UIImage(named: "Ico_Chevron_Down")
        iconButton.tintColor = Colors.primaryTextOnSurfaceColor
        
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
