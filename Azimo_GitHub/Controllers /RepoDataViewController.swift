//
//  RepoDataViewController.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 5/1/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class RepoDataViewController: UIViewController {
    
    //MARK: variables
    private var repo: Repo
    private lazy var labelNameRepo = UILabel()
    private lazy var textViewDescription = UITextView()
    private lazy var labelWatchers = UILabel()
    private lazy var labelStars = UILabel()
    private lazy var language = UILabel()
   
    init(repo: Repo) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }
    
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelNameRepo)
        view.addSubview(textViewDescription)
        view.addSubview(labelWatchers)
        view.addSubview(labelStars)
        view.addSubview(language)
        setupLayout()

    }
    
    override func loadView() {
       setupView()
       setupNameRepo()
       setupLanguage()
       setupWatchers()
       setupStars()
       setupDescription()
    }
    
    //MARK: Methods
    private func setupView(){
        view = UIView()
        view.frame.origin = .zero
        view.backgroundColor = .white
    }
    
    private func setupNameRepo(){
        labelNameRepo.text = "Name of repository: \(repo.name)"
        labelNameRepo.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupLanguage(){
        language.text = "Language: \(repo.language ?? "no info")"
        language.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupWatchers(){
        labelWatchers.text = "Watchers: \(repo.watchers)"
        labelWatchers.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupStars(){
        labelStars.text = "Stars: \(repo.stars)"
        labelStars.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func setupDescription(){
        textViewDescription.text = "Description: \(repo.description ?? "no info")"
        textViewDescription.font = UIFont.boldSystemFont(ofSize: 16)
        textViewDescription.isUserInteractionEnabled = false
    }
    
    private func setupLayout() {
        labelNameRepo.translatesAutoresizingMaskIntoConstraints = false
        textViewDescription.translatesAutoresizingMaskIntoConstraints = false
        labelWatchers.translatesAutoresizingMaskIntoConstraints = false
        labelStars.translatesAutoresizingMaskIntoConstraints = false
        language.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        let constan = UIScreen.main.bounds.height / 8
        NSLayoutConstraint.activate([
            labelNameRepo.topAnchor.constraint(equalTo: margins.topAnchor, constant: constan),
            labelNameRepo.leftAnchor.constraint(equalTo:  margins.leftAnchor, constant: 15),
            
            language.topAnchor.constraint(equalTo: labelNameRepo.topAnchor, constant: 30),
            language.leftAnchor.constraint(equalTo:  margins.leftAnchor, constant: 15),
            
            labelWatchers.topAnchor.constraint(equalTo: language.topAnchor, constant: 30),
            labelWatchers.leftAnchor.constraint(equalTo:  margins.leftAnchor, constant: 15),
            
            labelStars.topAnchor.constraint(equalTo: labelWatchers.topAnchor, constant: 30),
            labelStars.leftAnchor.constraint(equalTo:  margins.leftAnchor, constant: 15),
            
            textViewDescription.topAnchor.constraint(equalTo: labelStars.topAnchor, constant: 20),
            textViewDescription.leftAnchor.constraint(equalTo:  margins.leftAnchor, constant: 10),
            textViewDescription.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30),
            textViewDescription.heightAnchor.constraint(equalToConstant: 200)
            
            ])
    }
}
