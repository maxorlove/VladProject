//
//  MovieListViewCell.swift
//  VladProject
//
//  Created by Vladislav Kitov on 06.02.2023.
//

import UIKit
import SDWebImage

class MovieListViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
//    private let backgroundLabel = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
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
        
        [imageView, titleLabel, rateView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalToConstant: 136),
            imageView.heightAnchor.constraint(equalToConstant: 204),
            
            rateView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            rateView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)

        ])
        
    }
    
    private func setupStyles() {
        imageView.backgroundColor = Colors.secondaryBackgroundColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        
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
