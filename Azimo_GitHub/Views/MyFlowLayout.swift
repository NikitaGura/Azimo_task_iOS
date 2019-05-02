//
//  MyFlow.swift
//  Azimo_GitHub
//
//  Created by Nikita Gura on 5/1/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import Foundation

import UIKit

class MyFlowLayout: UICollectionViewFlowLayout {
    
    
    var ActiveDistance = CGFloat()
    let zoomFactor = CGFloat(0.3)
    
    public var cachedItemsAttributes = [LayoutAttributes]()
    public let spacing: CGFloat = 50
    
    
    
    override func prepare() {
        super.prepare()
       
        guard let collectionView = self.collectionView else { return }
        cachedItemsAttributes.removeAll()
        let sizeCollection = collectionView.frame.size.width
        ActiveDistance = sizeCollection * 3/10
        itemSize = CGSize(width: sizeCollection * 3/10, height: sizeCollection * 3/10)
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        for item in 0..<itemsCount {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = LayoutAttributes(forCellWith: indexPath)
            attributes.frame.size = itemSize
            attributes.frame.origin.y = (collectionView.bounds.height - itemSize.height) / 2
            attributes.frame.origin.x = CGFloat(indexPath.item) * (itemSize.width + spacing)
            attributes.color = .green
            cachedItemsAttributes.append(attributes)
        }
        
        
    }
    
    override var collectionViewContentSize: CGSize {
        let collection = collectionView!
        let height = collection.bounds.size.height
        let itemsCount = CGFloat(collection.numberOfItems(inSection: 0))
        let w = itemSize.width*itemsCount + spacing * itemsCount
        return CGSize(width: w, height: height)
    }
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    private func modifyLayoutAttributes(layoutattributes:
        LayoutAttributes , visibleRect: CGRect) {
        
        let distance = visibleRect.maxX - layoutattributes.center.x - visibleRect.size.width / 2
        
        let normalizedDistance = distance / ActiveDistance
        if(abs(distance) < ActiveDistance){
            let zoom = 1 + zoomFactor * ( 1 - abs(normalizedDistance))
            layoutattributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
        }
        
        let normalizedDistanceColor = distance / (ActiveDistance + 10)
        if(abs(distance) < (ActiveDistance + 10)){
            let zoom = 1 * ( 1 - abs(normalizedDistanceColor))
            let red = CGFloat(1.0)
            let green = 1 - zoom
            layoutattributes.color = UIColor(red: red, green:  green , blue: 0, alpha: 1)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = cachedItemsAttributes.filter { $0.frame.intersects(rect) }
        var visibleRect = CGRect()
        visibleRect.origin = self.collectionView!.contentOffset
        visibleRect.size = self.collectionView!.bounds.size
        
        for attributes in array {
            modifyLayoutAttributes(layoutattributes: attributes, visibleRect: visibleRect)
        }
        return cachedItemsAttributes
        
    }
    
    override func layoutAttributesForItem(at indexPath:
        IndexPath) -> UICollectionViewLayoutAttributes {
        
        return cachedItemsAttributes[indexPath.row]
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let layoutAttributes = layoutAttributesForElements(in: collectionView!.bounds)
        
        let centerOffset = collectionView!.bounds.size.width / 2
        let offsetWithCenter = proposedContentOffset.x + centerOffset
        
        let closestAttribute = layoutAttributes!
            .sorted { abs($0.center.x - offsetWithCenter) < abs($1.center.x - offsetWithCenter) }
            .first ?? LayoutAttributes()
        
        return CGPoint(x: closestAttribute.center.x - centerOffset, y: 0 )
    }
}

