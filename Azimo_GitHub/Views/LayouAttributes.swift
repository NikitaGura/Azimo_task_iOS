//
//  MyFlow.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 5/1/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class LayoutAttributes: UICollectionViewLayoutAttributes {
    
    var color: UIColor = UIColor()
    
    override func copy(with zone: NSZone?) -> Any {
        guard let attributes = super.copy(with: zone) as? LayoutAttributes else { return super.copy(with: zone) }
        attributes.color = color
        return attributes
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let attributes = object as? LayoutAttributes else { return false }
        guard attributes.color == color else { return false }
        return super.isEqual(object)
    }
}

