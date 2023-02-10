//
//  InfoTextView.swift
//  VladProject
//
//  Created by Vladislav Kitov on 09.02.2023.
//

import UIKit

class CardInfoView: UIView {
    
    // MARK: - Propetrties
    
    let valueLabel = UILabel()
    let descriptionLabel = UILabel()
//    let backgroundView = UIView()

    
    // MARK: - LifeCycle
    
//    init(label: String) {
//        super.init(frame: .zero)
//        setLabel(labelText: label)
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
        
        [valueLabel, descriptionLabel].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    
    private func configureStyles() {

        self.layer.cornerRadius = 24
        self.clipsToBounds = true
        self.backgroundColor = Colors.secondaryBackgroundColor
        valueLabel.font = FontStyle.subtitleFont
        valueLabel.textColor = Colors.primaryTextOnBackgroundColor
        
        descriptionLabel.font = FontStyle.extraSmallFont
        descriptionLabel.textColor = Colors.primaryTextOnBackgroundColor
    }
    
    func configureData(setValue: String, setDescription: String) {
        valueLabel.text = setValue
        descriptionLabel.text = setDescription
    }
    
}
