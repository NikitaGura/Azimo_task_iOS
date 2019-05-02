//
//  MyFlow.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 5/1/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class MyCellCollectionView: UICollectionViewCell {
    public var label: UILabel = {
        let  lab = UILabel()
        lab.textColor = .white
        lab.textAlignment = .center;
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "Bold", size: 19)
    
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8.0
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyCellCollectionView {
        override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
            super.apply(layoutAttributes)
    
            if let scLayoutAttributes = layoutAttributes as? LayoutAttributes{
                 self.backgroundColor = scLayoutAttributes.color
            }
           
        }
}
