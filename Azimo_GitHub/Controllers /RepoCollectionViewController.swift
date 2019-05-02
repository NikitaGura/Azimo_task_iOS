//
//  RepoCollectionViewController.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 5/1/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation
import UIKit

class RepoCollectionViewController: UIViewController {
    
    private var indexRotating = 0
    private var listRepo = [Repo]()
    
    lazy var myCollectionView: UICollectionView = {
        let cV = UICollectionView(frame: .zero, collectionViewLayout: MyFlowLayout())
        cV.backgroundColor = .white
        cV.translatesAutoresizingMaskIntoConstraints = false
        cV.dataSource = self
        cV.delegate = self
        cV.register(MyCellCollectionView.self, forCellWithReuseIdentifier: "MyCell")
        return cV
    }()
    
    init(listRepo: [Repo]) {
        self.listRepo = listRepo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myCollectionView)
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        
        var visibleRect = CGRect()
        
        visibleRect.origin = myCollectionView.contentOffset
        visibleRect.size = myCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = myCollectionView.indexPathForItem(at: visiblePoint) else { return }
        indexRotating = indexPath.row
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        guard let flowLayout = myCollectionView.collectionViewLayout as? MyFlowLayout else {return}
        
        let sizeItem = view.frame.size.width * 3/10
        myCollectionView.contentOffset.x = self.myCollectionView.contentInset.left + sizeItem * CGFloat(indexRotating) + flowLayout.spacing * CGFloat(indexRotating - 1) - view.center.x - sizeItem / 2
        
        let centerOffset = myCollectionView.bounds.size.width / 2
        let offsetWithCenter = myCollectionView.contentOffset.x + centerOffset
        let closestAttribute = flowLayout.cachedItemsAttributes
            .sorted { abs($0.center.x - offsetWithCenter) < abs($1.center.x - offsetWithCenter) }
            .first ?? LayoutAttributes()
        myCollectionView.contentOffset.x = closestAttribute.center.x - centerOffset
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            myCollectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            myCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            myCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        let sizeItem = view.frame.size.width * 3/10
        myCollectionView.contentInset.left = view.center.x - sizeItem / 2
        myCollectionView.contentInset.right = view.center.x - sizeItem / 2
        
    }
    
   
}

//MARK: - dataSource Collection
extension RepoCollectionViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRepo.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCellCollectionView{
            myCell.label.text = "\(listRepo[indexPath.row].name.prefix(9))"
            return myCell
        }
        return UICollectionViewCell()
    }
    
  
}

//MARK: - delegate Collection
extension RepoCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let repo = listRepo[indexPath.row]
        navigationController?.pushViewController(RepoDataViewController(repo: repo), animated: true)
    }
}
