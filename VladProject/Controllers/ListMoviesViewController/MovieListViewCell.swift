//
//  MovieListViewCell.swift
//  VladProject
//
//  Created by Vladislav Kitov on 08.01.2023.
//

import UIKit
import SDWebImage

class MovieListViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
   
//    private let imageHeight: NSLayoutConstraint = 1.5
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews()
        setupStyles()
    }
    
    private func addSubviews() {
        
        [imageView, titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
            
//            imageView.heightAnchor.constraint(equalToConstant: imageView.widthAnchor)
        ])
        
    }
    
    private func setupStyles() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
        titleLabel.font = FontSize.regularFont
        titleLabel.textColor = .black
    }
    
    func configure(with model: Movie) {
//        titleLabel.text = model.originalTitle
        titleLabel.text = "Тест"
//        imageView.image = nil
//        let url = URL(string: model.posterPath)
//        imageView.sd_setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
    
}
