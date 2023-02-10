//
//  ProfileViewController.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.02.2023.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Constants
    
    
    
    
    // MARK: - Propetrties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageBackgroundView = UIImageView()
    private let blurBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    private let coverMovieView = UIImageView()
    private let likeButton = SwitchButton()
    
    private let titleLabel = UILabel()
    
    private let rateView = CardInfoView()
    private let voteView = CardInfoView()
    private let popularityView = CardInfoView()
    private let statisticStackView = UIStackView()
    
    private let releaseDateView = TextInfoView()
    private let languageView = TextInfoView()
    private let infoStackView = UIStackView()
    
    private let descriptionLabel = UILabel()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupView()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        addSubviews()
        configureConstraints()
        setupStyles()
        configureData()
    }
    
    
    private func addSubviews() {
        //
        [imageBackgroundView, blurBackgroundView, coverMovieView, scrollView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [contentView].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [titleLabel, statisticStackView, infoStackView, descriptionLabel, likeButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    private func configureConstraints() {
        
        statisticStackView.axis = NSLayoutConstraint.Axis.horizontal
        statisticStackView.spacing = 8
        statisticStackView.distribution = .fillEqually
        statisticStackView.alignment = UIStackView.Alignment.top
        [rateView, voteView, popularityView].forEach {
            statisticStackView.addArrangedSubview($0)
        }
        
        infoStackView.axis = NSLayoutConstraint.Axis.horizontal
        infoStackView.spacing = 16
        infoStackView.distribution = .fillEqually
        infoStackView.alignment = UIStackView.Alignment.top
        [releaseDateView, languageView].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            imageBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 464),
            
            blurBackgroundView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 0),
            blurBackgroundView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: 0),
            blurBackgroundView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 0),
            blurBackgroundView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 0),
            
            coverMovieView.topAnchor.constraint(equalTo: blurBackgroundView.topAnchor, constant: 32),
            coverMovieView.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor, constant: 0),
            coverMovieView.widthAnchor.constraint(equalToConstant: 264),
            coverMovieView.heightAnchor.constraint(equalToConstant: 264*1.5),
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            likeButton.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -24),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            statisticStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            statisticStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            statisticStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            infoStackView.topAnchor.constraint(equalTo: statisticStackView.bottomAnchor, constant: 32),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            descriptionLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -64) //Важный констрейнт для работы скролла
        ])
        
    }
    
    
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = AttributedFontStyle.largeFont
    }
    
    private func setupStyles() {
        imageBackgroundView.backgroundColor = .green
        imageBackgroundView.layer.cornerRadius = 24
        imageBackgroundView.clipsToBounds = true
        
        blurBackgroundView.layer.cornerRadius = 24
        blurBackgroundView.clipsToBounds = true
        
        coverMovieView.layer.cornerRadius = 16
        coverMovieView.clipsToBounds = true
        
        view.backgroundColor = Colors.primaryBackgroundColor
        titleLabel.font = FontStyle.regularTitleFont
        titleLabel.textColor = Colors.primaryTextOnBackgroundColor
        titleLabel.numberOfLines = 2
        
        descriptionLabel.font = FontStyle.bodyFont
        descriptionLabel.textColor = Colors.primaryTextOnBackgroundColor
        descriptionLabel.numberOfLines = 0
        
        contentView.backgroundColor = Colors.primaryBackgroundColor
        contentView.layer.cornerRadius = 32
        scrollView.clipsToBounds = true
        scrollView.contentInset.top = 408
        
        likeButton.iconButton.image = UIImage(named: "Ico_Tile")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > -116 {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.likeButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            })
            
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.likeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
        
        
        //        if scrollView.contentOffset.y > -408 {
        //            print("\(scrollView.contentOffset.y)")
        //            //            let y = 300 - (scrollView.contentOffset.y + 300)
        //            //            imageBackgroundView.frame = CGRect(x: 0, y: y, width: scrollView.frame.width, height: 300)
        //            //            likeButton.isHidden = true
        //        } else {
        //            print("\(scrollView.contentOffset.y)")
        //            //                    Scrolling up: Parallax
        //            //                    let parallaxFactor: CGFloat = 0.25
        //            //                    let offsetY = scrollView.contentOffset.y * parallaxFactor
        //            //                    let minOffsetY: CGFloat = 8.0
        //            //                    let availableOffset = min(offsetY, minOffsetY)
        //            //                    let contentRectOffsetY = availableOffset / Constants.headerHeight
        //            //                    headerTopConstraint?.constant = view.frame.origin.y
        //            //                    headerHeightConstraint?.constant =
        //            //                        Constants.headerHeight - scrollView.contentOffset.y
        //            //                    headerImageView.layer.contentsRect =
        //            //                        CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
        //        }
        
    }
    
    private func configureData() {
        imageBackgroundView.image = UIImage(named: "Cover 1")
        coverMovieView.image = UIImage(named: "Cover 1")
        
        titleLabel.text = "Avatar: The Way of Water"
        
        rateView.configureData(setValue: "8.7", setDescription: "Rating")
        voteView.configureData(setValue: "23200", setDescription: "Vote count")
        popularityView.configureData(setValue: "87.951", setDescription: "Popularity")
        
        releaseDateView.configureData(setValue: "2022-12-14", setDescription: "Release date")
        languageView.configureData(setValue: "en", setDescription: "Language")
        
        descriptionLabel.text = "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope."
    }
    
}

//extension ProfileViewController: UIScrollViewDelegate {
//
//
//
//}

