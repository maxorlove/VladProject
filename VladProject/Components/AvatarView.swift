//
//  AvatarView.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.03.2023.
//

import UIKit

// MARK: - Struct

struct AvatarViewModel {

     enum Size: CGFloat {
         case large = 128
         case medium = 96
     }
}


// MARK: - Body

class AvatarView: UIView {
   
    
    // MARK: - Propetrties
    
    let userImage = UIImageView()
    var image = UIImage()
    
    // MARK: - LifeCycle
    
    init(setSize: AvatarViewModel.Size) {
        super.init(frame: .zero)
        
        NSLayoutConstraint.activate([
        userImage.widthAnchor.constraint(equalToConstant: setSize.rawValue),
        userImage.heightAnchor.constraint(equalToConstant: setSize.rawValue)
        ])
        self.layer.cornerRadius = setSize.rawValue/5
        
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
        configureSubviews()
        configureConstraints()
        configureStyles()
    }
    
    
    private func configureSubviews() {
        addSubview(userImage)
    }
    
    
    private func configureConstraints() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            userImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            userImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            userImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
        ])
    }
    
    private func configureStyles() {

        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Colors.secondaryBackgroundColor?.cgColor
        self.backgroundColor = Colors.secondaryBackgroundColor
        userImage.image = UIImage(named: "Avatar Placeholder")
        userImage.tintColor = Colors.secondaryBackgroundColor
    }
    
    func configureData(with image: UIImage?) {

        if image != UIImage(named: "") {
            self.backgroundColor = Colors.primaryBackgroundColor
            userImage.image = image
        } else {
            self.backgroundColor = Colors.primarySurfaceColor
            userImage.image = UIImage(named: "Avatar Placeholder")
        }
        
    }
    
}
