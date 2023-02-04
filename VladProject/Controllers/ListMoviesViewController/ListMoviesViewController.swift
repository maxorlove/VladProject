//
//  ViewController.swift
//  VladProject
//
//  Created by Orlov Maxim on 27.12.2022.
//

import UIKit

class ListMoviesViewController: UIViewController {
  
    
    // MARK: - Propetrties
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let networkClient = NetworkServiceImpl()
    private var dataSource: [Movie] = []
    private var currentPage: Int = 0
    private var totalPages: Int = 1
    
    let screenTitle = UILabel()
    let selectButton = SelectButton(label: "Popular")
    let switchButton = SwitchButton(setIcon: .ToList)
    let sortStack = UIStackView()
    
    var activeSorting = TypeSorting.popular
   
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        loadData(sorting: activeSorting, for: 1)
    }
    
    private func loadData(sorting sort: String, for page: Int) {
        networkClient.allMovies(sort: sort, page: page) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.dataSource += response.results
                    self?.dataSource.append(contentsOf: response.results)
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Fail")
                break
            }
        }
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        addSubviews()
        configureConstraints()
        setupCollectionView()
        setupNavigationBar()
        setupStyles()
    }
    
    private func addSubviews() {
        [collectionView, screenTitle, sortStack, selectButton, switchButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            screenTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            sortStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            sortStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        sortStack.axis = NSLayoutConstraint.Axis.horizontal
        sortStack.spacing = 8
        sortStack.alignment = UIStackView.Alignment.top
        [selectButton, switchButton].forEach {
            sortStack.addArrangedSubview($0)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieTileViewCell.self, forCellWithReuseIdentifier: Constants.gridCellReuseId)
        collectionView.backgroundColor = Colors.primaryBackgroundColor
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Movies"
        navigationController?.navigationBar.largeTitleTextAttributes = AttributedFontStyle.largeFont
    }
    
    private func setupStyles() {
        view.backgroundColor = Colors.primaryBackgroundColor
        selectButton.addTarget(self, action: #selector(selectTappedButton), for: .touchUpInside)
    }
    
    
    
    // Вызов Action Sheet для сортировки
    
    @objc func selectTappedButton() {
        // Create the action buttons for the alert.
        
        let popularMoviesAction = UIAlertAction(title: "Popular", style: .default) { (action) in
            self.selectButton.setLabel(labelText: "Popular")
            self.dataSource.removeAll()
            self.activeSorting = TypeSorting.popular
            self.loadData(sorting: self.activeSorting, for: 1)
        }
        
        let nowPlayingMoviesAction = UIAlertAction(title: "Now playing", style: .default) { (action) in
            self.selectButton.setLabel(labelText: "Now playing")
            self.dataSource.removeAll()
            self.activeSorting = TypeSorting.nowPlaying
            self.loadData(sorting: self.activeSorting, for: 1)
        }
        
        let topRatedMoviesAction = UIAlertAction(title: "Top rated", style: .default) { (action) in
            self.selectButton.setLabel(labelText: "Top rated")
            self.dataSource.removeAll()
            self.activeSorting = TypeSorting.topRated
            self.loadData(sorting: self.activeSorting, for: 1)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // Respond to user selection of the action.
        }
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Sorting", message: .none, preferredStyle: .actionSheet)
        [popularMoviesAction, nowPlayingMoviesAction, topRatedMoviesAction, cancelAction].forEach {
            alert.addAction($0)
        }
        
        self.present(alert, animated: true) {
            // The alert was presented
        }
    }
    
}


// MARK: - Extensions

extension ListMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.gridCellReuseId,
            for: indexPath
        ) as! MovieTileViewCell
        cell.configure(with: model)
        return cell
    }
}

extension ListMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: Constants.itemWidth*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if dataSource.count - 3 == indexPath.row, currentPage < totalPages {
            currentPage += 1
            loadData(sorting: activeSorting, for: currentPage)
        }
    }
}



private enum Constants {
    static let gridCellReuseId = "GridCollectionViewCellIdentifier"
    static let numberOfItemsInRow: CGFloat = 2
    static let itemWidth: CGFloat = (UIScreen.main.bounds.width / numberOfItemsInRow) - spacing*1.5
    static let spacing: CGFloat = 8
}

private enum TypeSorting {
    static let popular = "popular"
    static let nowPlaying = "now_playing"
    static let topRated = "top_rated"
//  static let upcoming = "upcoming" // не отвечает
//  static let latest = "latest" // не отвечает
}

