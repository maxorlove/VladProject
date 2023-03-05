//
//  ProfileViewController.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.02.2023.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func configureData()
//    func contactUpdated(with contact: User)
//    func removeContact(with contact: User)
//    func addNewContact(with contact: User)
}

class ProfileViewController: UIViewController, UIScrollViewDelegate, ProfileViewDelegate {
    
    // MARK: - Constants
    

    
    
    // MARK: - Propetrties
    private let defaults = UserDefaults.standard
    private let avatarView = AvatarView(setSize: .medium)
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let labelStack = UIStackView()
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        configureSubviews()
        configureConstraints()
        configureNavigationBar()
        configureStyles()
        configureData()
    }
    
    
    private func configureSubviews() {
        [avatarView, labelStack, usernameLabel, emailLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            labelStack.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor, constant: 0),
            labelStack.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 24),
            labelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
        
        labelStack.axis = NSLayoutConstraint.Axis.vertical
        labelStack.spacing = 4
//        labelStack.alignment = UIStackView.Alignment.top
        [usernameLabel, emailLabel].forEach {
            labelStack.addArrangedSubview($0)
        }
    }

    private func configureNavigationBar() {
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = AttributedFontStyle.largeFont
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Ico_Profile"), style: .plain, target: self, action: #selector(editTappedButton))
    }
    
    private func configureStyles() {
        view.backgroundColor = Colors.primaryBackgroundColor
        usernameLabel.font = FontStyle.smallTitleFont
        usernameLabel.textColor = Colors.primaryTextOnSurfaceColor
        
        emailLabel.font = FontStyle.bodyFont
        emailLabel.textColor = Colors.secondaryTextOnSurfaceColor
    }

    internal func configureData() {
        var profile: Profile = .init(
            name: UserDefaults.standard.string(forKey: DataProfileKeys.userName.rawValue),
            email: UserDefaults.standard.string(forKey: DataProfileKeys.emailAddress.rawValue),
            photo: UIImage(named: "")
            )
        usernameLabel.text = profile.name
        emailLabel.text = profile.email
    }
    
    @objc func editTappedButton() {
        let profileEditInfoViewController = ProfileEditInfoViewController()
        let navigationController = UINavigationController(rootViewController: profileEditInfoViewController)
        profileEditInfoViewController.delegate = self
//        profileEditInfoViewController.configureProfileData(with: profile)
        present(navigationController, animated: true)
    }
    
}


