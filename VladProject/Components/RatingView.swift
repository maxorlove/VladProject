//
//  RatingView.swift
//  VladProject
//
//  Created by Vladislav Kitov on 04.02.2023.
//

import Foundation
import UIKit


class RatingView: UIView {
    
    // MARK: - Struct
    
    struct RatingViewModel {
        
        enum Size: String {
            case Large = "Ico_Tile"
            case Regular = "Ico_List"
        }
        
    }
    
    // MARK: - Propetrties
    
    let labelView = UILabel()
    private let iconView = UIImageView()
    private let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    
    // MARK: - LifeCycle
    
//    init(setRate: String) {
//        super.init(frame: .zero)
//        labelView.text = setRate
//        configureView()
//    }
    
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
        
        [backgroundView, labelView, iconView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 36),
//            self.widthAnchor.constraint(equalToConstant: 64),
            
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
          
            iconView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            
            labelView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 8),
            
            self.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 12)
            
        ])
    }
    
    private func configureStyles() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        iconView.image = UIImage(named: "Ico_Star_Filled")
        iconView.tintColor = Colors.accentTextColor
        
        labelView.font = FontStyle.regularFont
        labelView.textColor = Colors.accentTextColor

    }
    
}


    

