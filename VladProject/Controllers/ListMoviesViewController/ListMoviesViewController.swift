//
//  ViewController.swift
//  VladProject
//
//  Created by Orlov Maxim on 27.12.2022.
//

import UIKit

class ListMoviesViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Layout {
        case grid
        case list
    }
    
    private enum CellConstants {
        static let gridCellReuseId = "GridCollectionViewCellIdentifier"
        static let spacingForGrid: CGFloat = 8
        static let numberOfItemsInRowForGrid: CGFloat = 2
        static let cellGridWidth: CGFloat = (UIScreen.main.bounds.width / numberOfItemsInRowForGrid) - spacingForGrid*1.5
        static let cellGridHeight: CGFloat = cellGridWidth*1.5
        
        static let listCellReuseId = "ListCollectionViewCellIdentifier"
        static let numberOfItemsInRowForList: CGFloat = 1
        static let spacingForList: CGFloat = 0
        static let cellListWidth: CGFloat = UIScreen.main.bounds.width
        static let cellListHeight: CGFloat = cellListWidth/1.8
    }
    
    
    private enum TypeSorting {
        static let popular = "popular"
        static let nowPlaying = "now_playing"
        static let topRated = "top_rated"
    }
    
    private enum LoadType {
        case load
        case reload
    }
    
    
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
    
    private let tileViewCell = MovieTileViewCell()
    private let listViewCell = MovieListViewCell()
    
    private let screenTitle = UILabel()
    private let selectButton = SelectButton(label: "Popular")
    private var switchButton = IconButton(setIcon: "Ico_List")
    private let sortStack = UIStackView()
    
    private var currentSorting = TypeSorting.popular
    var currentLayout: Layout = .grid
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        loadData(loadType: .load, sorting: currentSorting, for: 1)
    }
    
    private func loadData(loadType: LoadType, sorting sort: String, for page: Int) {
        networkClient.allMovies(sort: sort, page: page) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    
                    if loadType == .reload {
                        self?.dataSource.removeAll()
                    }
                    
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
        collectionView.backgroundColor = Colors.primaryBackgroundColor
        collectionView.register(MovieListViewCell.self, forCellWithReuseIdentifier: CellConstants.listCellReuseId)
        collectionView.register(MovieTileViewCell.self, forCellWithReuseIdentifier: CellConstants.gridCellReuseId)
        collectionView.contentInset.bottom = 96

    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = AttributedFontStyle.largeFont
    }
    
    private func setupStyles() {
        view.backgroundColor = Colors.primaryBackgroundColor
        selectButton.addTarget(self, action: #selector(selectTappedButton), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(switchTappedButton), for: .touchUpInside)
    }
    
    
    // Вызов Action Sheet для сортировки
    
    @objc func selectTappedButton() {
        
        let popularMoviesAction = UIAlertAction(title: "Popular", style: .default) { (action) in
            self.selectButton.setLabel(labelText: "Popular")
            self.currentSorting = TypeSorting.popular
            self.loadData(loadType: .reload, sorting: self.currentSorting, for: 1)
            
            UIView.animate(withDuration: 0.2) { self.view.layoutIfNeeded() }
        }
        
        let nowPlayingMoviesAction = UIAlertAction(title: "Now playing", style: .default) { (action) in
            self.selectButton.setLabel(labelText: "Now playing")
            self.currentSorting = TypeSorting.nowPlaying
            self.loadData(loadType: .reload, sorting: self.currentSorting, for: 1)
            
            UIView.animate(withDuration: 0.2) { self.view.layoutIfNeeded() }
        }
        
        let topRatedMoviesAction = UIAlertAction(title: "Top rated", style: .default) { (action) in
            self.selectButton.setLabel(labelText: "Top rated")
            self.currentSorting = TypeSorting.topRated
            self.loadData(loadType: .reload, sorting: self.currentSorting, for: 1)
            
            UIView.animate(withDuration: 0.2) { self.view.layoutIfNeeded() }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        let alert = UIAlertController(title: "Sorting", message: .none, preferredStyle: .actionSheet)
        [popularMoviesAction, nowPlayingMoviesAction, topRatedMoviesAction, cancelAction].forEach {
            alert.addAction($0)
        }
        
        self.present(alert, animated: true) {
            
        }
    }
    
    @objc func switchTappedButton() {
        if currentLayout == .grid {
            switchButton.iconButton.image = UIImage(named: "Ico_Tile")
            currentLayout = .list
        } else {
            switchButton.iconButton.image = UIImage(named: "Ico_List")
            currentLayout = .grid
        }
        collectionView.reloadData()
    }
    
}


// MARK: - Extensions

extension ListMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        
        switch currentLayout {
            
        case .grid:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellConstants.gridCellReuseId,
                for: indexPath
            ) as! MovieTileViewCell
            cell.configure(with: model)
            return cell
            
        case .list:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellConstants.listCellReuseId,
                for: indexPath
            ) as! MovieListViewCell
            cell.configure(with: model)
            return cell
        }
    }
}

extension ListMoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch currentLayout {
        case .grid:
            return CGSize(width: CellConstants.cellGridWidth, height: CellConstants.cellGridHeight)
        case .list:
            return CGSize(width: CellConstants.cellListWidth, height: CellConstants.cellListHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch currentLayout {
        case .grid:
            return CellConstants.spacingForGrid
        case .list:
            return CellConstants.spacingForList
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch currentLayout {
        case .grid:
            return CellConstants.spacingForGrid
        case .list:
            return CellConstants.spacingForList
        }
    }
}
