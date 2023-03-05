//
//  ProfileEditInfoViewController.swift
//  VladProject
//
//  Created by Vladislav Kitov on 05.03.2023.
//

import UIKit

class ProfileEditInfoViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    // MARK: - Constants
    

    
    
    // MARK: - Propetrties
    
    private let usernameField = TextFieldView(labelText: "Username", placeholderText: "", keyboardType: .default)
    private let emailField = TextFieldView(labelText: "Email", placeholderText: "", keyboardType: .emailAddress)
    private let saveButton = Button(label: "Save", style: .Primary)
    private let cancelButton = Button(label: "Cancel", style: .Secondary)
    
    private let buttonStack = UIStackView()
    
    
    private let avatarView = AvatarView(setSize: .large)
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let defaults = UserDefaults.standard
    
    var profile: Profile = .init(
        name: UserDefaults.standard.string(forKey: DataProfileKeys.userName.rawValue),
        email: UserDefaults.standard.string(forKey: DataProfileKeys.emailAddress.rawValue),
        photo: UIImage(named: "")
        )
    
    weak var delegate: ProfileViewDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
        
        setupView()
    }
    
    
    // MARK: - Methods
    
    private func setupView() {
        configureSubviews()
        configureConstraints()
        configureNavigationBar()
        configureStyles()
        configureProfileData()
    }
    
    
    private func configureSubviews() {

        [avatarView, usernameField, buttonStack, emailField, saveButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    
    private func configureConstraints() {
        
        NSLayoutConstraint.activate([
            
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            usernameField.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 32),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 8),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            buttonStack.leadingAnchor.constraint(equalTo: emailField.leadingAnchor, constant: 0),
            buttonStack.trailingAnchor.constraint(equalTo: emailField.trailingAnchor, constant: 0),
            
        ])
        
        buttonStack.axis = NSLayoutConstraint.Axis.horizontal
        buttonStack.spacing = 16
        [cancelButton, saveButton].forEach {
            buttonStack.addArrangedSubview($0)
        }
        
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Edit Profile"

        
    }
    
    private func configureStyles() {
        view.backgroundColor = Colors.primaryBackgroundColor
        saveButton.addTarget(self, action: #selector(touchSaveButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(touchCancelButton), for: .touchUpInside)
    }
    
    @objc private func touchSaveButton() {
        defaults.set(usernameField.textField.text, forKey: DataProfileKeys.userName.rawValue)
        defaults.set(emailField.textField.text, forKey: DataProfileKeys.emailAddress.rawValue)
        delegate?.configureData()
        dismiss(animated: true)
    }
    
    @objc private func touchCancelButton() {
        dismiss(animated: true)
    }
    
    func configureProfileData() {
        usernameField.textField.text = profile.name
        emailField.textField.text = profile.email
    }

    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        usernameField.endEditing(true)
        emailField.endEditing(true)
    }

}
