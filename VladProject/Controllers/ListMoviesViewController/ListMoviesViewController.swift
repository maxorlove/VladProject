//
//  ViewController.swift
//  VladProject
//
//  Created by Orlov Maxim on 27.12.2022.
//

import UIKit

class ListMoviesViewController: UIViewController {

    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let networkClient = NetworkServiceImpl()
    private var dataSource: [Character] = []
    private var currentPage: Int = 0
    private var totalPages: Int = 1
    
    let screenTitle = UILabel()
    let selectButton = SelectButton(setText: "Popular")
    let switchButton = SwitchButton(setIcon: .IsTile)
    //    let image = UIImageView()
    let sortStack = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        loadData(for: 0)
    }
    
    private func loadData(for page: Int) {
        networkClient.allCharacters(page: page) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.dataSource.append(contentsOf: response.results)
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                break
            }
        }
    }
    
    
    private func setupView() {
        addSubviews()
        configureConstraints()
        setupStyles()
        setupCollectionView()
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
            
            //            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //            image.heightAnchor.constraint(equalToConstant: 256),
            //            image.widthAnchor.constraint(equalToConstant: 170)
            collectionView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 8),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            

            
        ])
        
        sortStack.axis = NSLayoutConstraint.Axis.horizontal
        sortStack.spacing = 8
        sortStack.alignment = UIStackView.Alignment.top
        
        [selectButton, switchButton].forEach {
            sortStack.addArrangedSubview($0)
        }
        
//        sortStack.addArrangedSubview(selectButton)
//        sortStack.addArrangedSubview(switchButton)
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieListViewCell.self, forCellWithReuseIdentifier: Constants.gridCellReuseId)
    }
    
    private func setupStyles() {
        view.backgroundColor = Colors.primaryBackgroundColor
        //        image.image = UIImage(named: "Cover")
        
        screenTitle.font = FontSize.largeFont
        screenTitle.textColor = Colors.primaryTextOnBackgroundColor
        screenTitle.text = "Movies"
        
    }
    
}

extension ListMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.gridCellReuseId,
            for: indexPath
        ) as! MovieListViewCell
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
            loadData(for: currentPage)
        }
    }
    
}

private enum Constants {
    static let gridCellReuseId = "GridCollectionViewCellIdentifier"
    static let numberOfItemsInRow: CGFloat = 2
    static let itemWidth: CGFloat = (UIScreen.main.bounds.width / numberOfItemsInRow) - spacing*1.5
    static let spacing: CGFloat = 8
}
