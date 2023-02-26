//
//  MovieListViewCell.swift
//  VladProject
//
//  Created by Vladislav Kitov on 08.01.2023.
//

import UIKit
import SDWebImage

class MovieTileViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let backgroundLabel = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
    private let titleLabel = UILabel()
    private let rateView = RatingView()
    
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
        
        [imageView, backgroundLabel, titleLabel, rateView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            backgroundLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 4),
            backgroundLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -4),
            backgroundLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -4),
            backgroundLabel.heightAnchor.constraint(equalToConstant: 64),
            
            rateView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 4),
            rateView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -4),
            
            titleLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: backgroundLabel.topAnchor, constant: 8)

        ])
        
    }
    
    private func setupStyles() {
        imageView.backgroundColor = Colors.secondaryBackgroundColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        
        backgroundLabel.layer.cornerRadius = 20
        backgroundLabel.clipsToBounds = true
        
        titleLabel.font = FontStyle.subtitleFont
        titleLabel.textColor = Colors.accentTextColor
        titleLabel.numberOfLines = 2
        
        
    }
    
    func configure(with model: Movie) {
        rateView.labelView.text = "\(model.voteAverage)"
        titleLabel.text = model.originalTitle
        imageView.image = nil
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(model.posterPath)")
        imageView.sd_setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    @objc func animateDecrease() {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    @objc func animateIncrease() {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform.identity
        }
    }
    
}
