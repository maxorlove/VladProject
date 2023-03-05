//
//  TextFieldView.swift
//  VladProject
//
//  Created by Vladislav Kitov on 26.02.2023.
//

import UIKit

class TextFieldView: UIView, UITextFieldDelegate {
   
    // MARK: - Propetrties
    
    let textField = UITextField()
    var textPlaceholder: String?
    var textFieldLabel = UILabel()
    
    
    // MARK: - LifeCycle
    
    init(labelText: String, placeholderText: String, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        textField.placeholder = placeholderText
        textFieldLabel.text = labelText
        textField.keyboardType = keyboardType
        textField.delegate = self
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.frame = bounds
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    
    // MARK: - Methods
    
    private func configureView() {
        configureSubviews()
        configureConstraints()
        configureStyles()
    }
    
    
    private func configureSubviews() {
        [textFieldLabel, textField].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 88),
            textFieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textFieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            textFieldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 32),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: textFieldLabel.bottomAnchor, constant: 4)
        ])
    }

    
    private func configureStyles() {
        self.backgroundColor = Colors.secondaryBackgroundColor
        self.layoutMargins.left = 32
        self.layer.cornerRadius = 24
        textField.textColor = Colors.primaryTextOnBackgroundColor
        textField.autocorrectionType = .no
        textFieldLabel.font = FontStyle.bodyFont
        textFieldLabel.textColor = Colors.secondaryTextOnBackgroundColor
        textField.font = FontStyle.smallTitleFont
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            // Hide the keyboard
            textField.resignFirstResponder()

            // Return true to indicate that the text field should process the return key
            return true
        }
    
}
