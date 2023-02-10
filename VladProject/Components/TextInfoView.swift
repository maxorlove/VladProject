//
//  TextInfoView.swift
//  VladProject
//
//  Created by Vladislav Kitov on 10.02.2023.
//

import UIKit

class TextInfoView: UIView {
    
    // MARK: - Propetrties
    
    let descriptionLabel = UILabel()
    let valueLabel = UILabel()

    
    // MARK: - LifeCycle
    
    
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
        [descriptionLabel, valueLabel].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 0),
            self.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 0),
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            
            valueLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            
        ])
    }
    
    
    private func configureStyles() {

        descriptionLabel.font = FontStyle.extraSmallFont
        descriptionLabel.textColor = Colors.primaryTextOnBackgroundColor
        valueLabel.font = FontStyle.subtitleFont
        valueLabel.textColor = Colors.primaryTextOnBackgroundColor
        
    }
    
    func configureData(setValue: String, setDescription: String) {
        valueLabel.text = setValue
        descriptionLabel.text = setDescription
    }
    
}
