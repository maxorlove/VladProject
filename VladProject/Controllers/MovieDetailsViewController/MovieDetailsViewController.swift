//
//  MovieDetailsViewController.swift
//  VladProject
//
//  Created by Vladislav Kitov on 15.02.2023.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Constants
    
    struct Constants {
        static let backgroundHeight: CGFloat = 464
        static let coverHeight: CGFloat = 396
    }
    
    
    // MARK: - Propetrties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageBackgroundView = UIImageView()
    private var imageBackgroundHeightConstraint: NSLayoutConstraint!
    
    private let blurBackgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    
    
    private let coverMovieView = UIImageView()
    private var coverTopConstraint: NSLayoutConstraint!
    private var coverHeightConstraint: NSLayoutConstraint!
    private var coverWidhtConstraint: NSLayoutConstraint!
    
    private let likeButton = IconButton()
    
    private let titleLabel = UILabel()
    
    private let rateView = CardInfoView(setIcon: .True, iconImage: Icons.starFilled)
    private let voteView = CardInfoView()
    private let popularityView = CardInfoView()
    private let statisticStackView = UIStackView()
    
    private let releaseDateView = TextInfoView()
    private let languageView = TextInfoView()
    private let infoStackView = UIStackView()
    
    private let descriptionLabel = UILabel()
    
    weak var delegate: MovieDetailsViewDelegate?
    
    var currentMovie: Movie?
    
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
//        configureMovieData()
    }
    
    
    private func addSubviews() {
        //
        [imageBackgroundView, blurBackgroundView, coverMovieView, scrollView, likeButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [contentView].forEach {
            scrollView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [titleLabel, statisticStackView, infoStackView, descriptionLabel].forEach {
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
        
        imageBackgroundHeightConstraint = imageBackgroundView.heightAnchor.constraint(equalToConstant: Constants.backgroundHeight)
        
        coverTopConstraint = coverMovieView.topAnchor.constraint(equalTo: blurBackgroundView.topAnchor, constant: 32)
        coverHeightConstraint = coverMovieView.heightAnchor.constraint(equalToConstant: Constants.coverHeight)
        coverWidhtConstraint = coverMovieView.widthAnchor.constraint(equalToConstant: Constants.coverHeight/1.5)
        
        NSLayoutConstraint.activate([
            
            imageBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imageBackgroundHeightConstraint,
            
            blurBackgroundView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 0),
            blurBackgroundView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: 0),
            blurBackgroundView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: 0),
            blurBackgroundView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 0),
            
            //            coverMovieView.topAnchor.constraint(equalTo: blurBackgroundView.topAnchor, constant: 32),
            coverTopConstraint,
            coverMovieView.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor, constant: 0),
            coverWidhtConstraint,
            coverHeightConstraint,
            //            coverMovieView.heightAnchor.constraint(equalToConstant: Constants.coverHeight),
            
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
        self.navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationBar.largeTitleTextAttributes = AttributedFontStyle.largeFont
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupStyles() {
        imageBackgroundView.backgroundColor = .green
        imageBackgroundView.layer.cornerRadius = 24
        imageBackgroundView.clipsToBounds = true
        imageBackgroundView.contentMode = .scaleAspectFill
        
        blurBackgroundView.layer.cornerRadius = 24
        blurBackgroundView.clipsToBounds = true
        
        coverMovieView.layer.cornerRadius = 16
        coverMovieView.clipsToBounds = true
        coverMovieView.contentMode = .scaleAspectFill
        
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
        
        likeButton.iconView.image = Icons.heartStroked.image
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < -408 {
            imageBackgroundHeightConstraint.constant = Constants.backgroundHeight - scrollView.contentOffset.y - 408
            
            coverHeightConstraint.constant = Constants.coverHeight - scrollView.contentOffset.y - 408
            coverWidhtConstraint.constant = coverHeightConstraint.constant/1.5
        } else {
            imageBackgroundHeightConstraint.constant = Constants.backgroundHeight - scrollView.contentOffset.y - 408
//            let parallaxFactor: CGFloat = 0.25
//            let offsetY = scrollView.contentOffset.y * parallaxFactor
//            let minOffsetY: CGFloat = 8.0
//            let availableOffset = min(offsetY, minOffsetY)
//            let contentRectOffsetY = availableOffset / Constants.coverHeight
//            coverTopConstraint?.constant = view.frame.origin.y
//            coverHeightConstraint?.constant = Constants.coverHeight - scrollView.contentOffset.y
//            coverMovieView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
//            coverTopConstraint?.constant = view.frame.origin.y
//            let parallaxFactor: CGFloat = 1
//            let offsetY = scrollView.contentOffset.y * parallaxFactor
//            coverTopConstraint?.constant = Constants.coverHeight + offsetY - 408
            
        }
        
        
        if scrollView.contentOffset.y > -116 {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.likeButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            })
            
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.likeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
    func configureMovieData(with movie: Movie) {
        
        currentMovie = movie
        let path = currentMovie!.posterPath
        print(path)
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(path)")
        imageBackgroundView.sd_setImage(with: url)
        coverMovieView.sd_setImage(with: url)
        
        titleLabel.text = currentMovie?.originalTitle
        rateView.configureData(setValue: "\(currentMovie?.voteAverage ?? 0)", setDescription: "Rating")

        voteView.configureData(setValue: "\(currentMovie?.voteCount ?? 0)", setDescription: "Vote count")
        popularityView.configureData(setValue: "\(currentMovie?.popularity ?? 0)", setDescription: "Popularity")
        
        releaseDateView.configureData(setValue: currentMovie?.releaseDate ?? "Unknown", setDescription: "Release date")
        languageView.configureData(setValue: currentMovie!.originalLanguage, setDescription: "Language")
        
        descriptionLabel.text = currentMovie?.overview
    }
}
