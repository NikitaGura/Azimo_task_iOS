//
//  ViewController.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 4/30/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    //MARK: variables
    private lazy var getReposButton: UIButton = UIButton(type: .system)
    private lazy var userNameLabel: UILabel = UILabel()
    private lazy var textFieldUserName: UITextField = UITextField()
    private let tapDismissKeybord = UITapGestureRecognizer()
    private lazy var indicatorActivity = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userNameLabel)
        view.addSubview(textFieldUserName)
        view.addSubview(getReposButton)
        view.addSubview(indicatorActivity)
        setupLayout()
        setupKeybord()
    }

    override func loadView() {
        setupView()
        setupGetReposButton()
        setupUserNameLabel()
        setupTextFieldUserName()
        setTapDismissKeybord()
        setupIndicatorActivity()
    }
    
    
    //MARK: selectors
    @objc func dismissKeybord(){
         self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.size.height / 2 < keyboardSize.height{
                
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func getRepos(){
        indicatorActivity.startAnimating()
        self.view.endEditing(true)
        self.getReposButton.isEnabled = false
        guard let userName = self.textFieldUserName.text else {return}
        let networkProcessor = NetworkProcessor(userName: userName.trimmingCharacters(in: .whitespacesAndNewlines))
        
        networkProcessor.getJSON({ [weak self] (model) in
            DispatchQueue.main.async {
                self?.getReposButton.isEnabled = true
                self?.indicatorActivity.stopAnimating()
                self?.pushViewController(listRepo: model)
            }
        }, userNotExist: { [weak self] in
            let alert = UIAlertController(title: "Alert", message: "User does not exist", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                switch action.style{
                case .default:
                    self?.textFieldUserName.becomeFirstResponder()
                    self?.getReposButton.isEnabled = true
                    
                default:
                    break
                }}))
            self?.present(alert, animated: true, completion: {self?.indicatorActivity.stopAnimating()})
        }) { [weak self] in
            let alert = UIAlertController(title: "Alert", message: "Error connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                switch action.style{
                case .default:
                    self?.textFieldUserName.becomeFirstResponder()
                    self?.getReposButton.isEnabled = true
                    
                default:
                    break
                }}))
            self?.present(alert, animated: true, completion: {self?.indicatorActivity.stopAnimating()})
            
            return
        }
    }
    
    //MARK: Methods
    private func setupIndicatorActivity(){
        indicatorActivity.hidesWhenStopped = true
        indicatorActivity.style = .gray
    }
    
    private func setupView(){
        view = UIView()
        view.frame.origin = .zero
        view.backgroundColor = .white
    }
    
    private func setupGetReposButton(){
        getReposButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getReposButton.setTitle("Show Repositories", for: [])
        getReposButton.addTarget(self, action: #selector(getRepos), for: .touchUpInside)
    }
    
    private func setupUserNameLabel(){
        userNameLabel.text = "User Name"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupTextFieldUserName(){
        textFieldUserName.font = UIFont.boldSystemFont(ofSize: 16)
        textFieldUserName.borderStyle = .roundedRect
        textFieldUserName.textAlignment = .center
    }
    
    private func setupLayout() {
        getReposButton.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldUserName.translatesAutoresizingMaskIntoConstraints = false
        indicatorActivity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            getReposButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getReposButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            
            textFieldUserName.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,
            textFieldUserName.centerYAnchor.constraint(equalTo: getReposButton.topAnchor, constant: -20),
            textFieldUserName.widthAnchor.constraint(equalToConstant: 150),
            
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameLabel.centerYAnchor.constraint(equalTo: textFieldUserName.topAnchor, constant: -20),
            
            indicatorActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorActivity.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            ])
    }
    
    private func setupKeybord(){
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    fileprivate func setTapDismissKeybord(){
        tapDismissKeybord.addTarget(self, action: #selector(dismissKeybord))
        tapDismissKeybord.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapDismissKeybord)
    }
    
    fileprivate func pushViewController(listRepo: [Repo]){
        let repoCollectionViewController = RepoCollectionViewController(listRepo: listRepo)
        navigationController?.pushViewController(repoCollectionViewController, animated: true)
    }
}

