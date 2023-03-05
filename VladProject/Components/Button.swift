//
//  Button.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.03.2023.
//

import UIKit

struct ButtonViewModel {
    
    enum ButtonStyle {
        case Primary
        case Secondary
    }
}

class Button: UIButton {
    

    
    // MARK: - Propetrties
    
    var labelButton = UILabel()
    let generator = UIImpactFeedbackGenerator(style: .light)
    var buttonStyle: ButtonViewModel.ButtonStyle = .Primary
    // MARK: - LifeCycle
    
    init(label: String, style: ButtonViewModel.ButtonStyle) {
        super.init(frame: .zero)
        buttonStyle = style
        setLabel(labelText: label)
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
        
        [labelButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 88),
            self.leadingAnchor.constraint(equalTo: labelButton.leadingAnchor, constant: -32),
            self.trailingAnchor.constraint(equalTo: labelButton.trailingAnchor, constant: 32),
            labelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func setLabel(labelText: String) {
        labelButton.text = labelText.uppercased()
    }
    
    private func configureStyles() {
        
        
        switch buttonStyle {
            
        case .Primary:
            self.backgroundColor = Colors.accentSurfaceColor
            labelButton.textColor = Colors.accentTextColor
        case .Secondary:
            self.backgroundColor = Colors.secondaryBackgroundColor
            labelButton.textColor = Colors.primaryTextOnSurfaceColor
        }
        
        
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
        labelButton.font = FontStyle.actionFont
        labelButton.textAlignment = .center
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
