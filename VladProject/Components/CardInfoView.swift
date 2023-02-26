//
//  InfoTextView.swift
//  VladProject
//
//  Created by Vladislav Kitov on 09.02.2023.
//

import UIKit

class CardInfoView: UIView {
    
    // MARK: - Struct
    
    struct CardInfoViewModel {
        
        enum IconIsOn {
            case True
            case False
        }
    }
    
    
    // MARK: - Propetrties
    
    let valueLabel = UILabel()
    let descriptionLabel = UILabel()
    var iconStatus: CardInfoViewModel.IconIsOn = .False
    let iconView = UIImageView()
    
    
    
    // MARK: - LifeCycle
    
    init(setIcon: CardInfoViewModel.IconIsOn, iconImage: Icons) {
        super.init(frame: .zero)
        iconStatus = setIcon
        iconView.image = iconImage.image
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
        
        switch iconStatus {
            
        case .True:
            [valueLabel, descriptionLabel, iconView].forEach {
                self.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            
        case .False:
            [valueLabel, descriptionLabel].forEach {
                self.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch iconStatus {
            
        case .True:
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 88),
                
                self.leadingAnchor.constraint(equalTo: iconView.leadingAnchor, constant: -16),
                
                iconView.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
                iconView.widthAnchor.constraint(greaterThanOrEqualToConstant: 24),
                iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
                
                valueLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
                valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
                
                descriptionLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 0),
            ])
            
        case .False:
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 88),
                
                self.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -24),
                self.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 24),
                valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
                
                descriptionLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 0),
            ])
        }
    }
    
    
    private func configureStyles() {
        
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
        self.backgroundColor = Colors.secondaryBackgroundColor
        valueLabel.font = FontStyle.subtitleFont
        valueLabel.textColor = Colors.primaryTextOnBackgroundColor
        iconView.tintColor = Colors.primaryTextOnBackgroundColor
        descriptionLabel.font = FontStyle.extraSmallFont
        descriptionLabel.textColor = Colors.primaryTextOnBackgroundColor
    }
    
    func configureData(setValue: String, setDescription: String) {
        valueLabel.text = setValue
        descriptionLabel.text = setDescription
    }
    
}
