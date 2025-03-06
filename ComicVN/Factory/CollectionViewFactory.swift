//
//  CollectionView.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit

class CollectionViewFactory {
    static func createCollectionView(scrollDirection: UICollectionView.ScrollDirection = .horizontal,
                                     minimumInteritemSpacing: CGFloat = 6,
                                     estimated: Bool = true,
                                     top: CGFloat = 0,
                                     left: CGFloat = 0,
                                     right: CGFloat = 0,
                                     bottom: CGFloat = 0 ) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        if estimated {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        } else {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.8, height: 165)
        }
        layout.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }
    
    static func create2ColumCollectionView(scrollDirection: UICollectionView.ScrollDirection = .horizontal,
                                           minimumInteritemSpacing: CGFloat = 6,
                                           padding: CGFloat = 0,
                                           top: CGFloat = 0,
                                           left: CGFloat = 0,
                                           right: CGFloat = 0,
                                           bottom: CGFloat = 0,
                                           width: CGFloat = 0,
                                           height: CGFloat = 0) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - padding) / 2, height: height)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = 10
    
        layout.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        
        return collectionView
        
    }
}


class ColumnFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let columnCount = 2
        var newAttributes: [UICollectionViewLayoutAttributes] = []
        var columnHeights = [CGFloat](repeating: sectionInset.top, count: columnCount)
        
        for attribute in attributes {
            if attribute.representedElementCategory == .cell {
                let minColumnIndex = columnHeights.enumerated().min(by: { $0.1 < $1.1 })?.0 ?? 0
                let xOffset = sectionInset.left + CGFloat(minColumnIndex) * (itemSize.width + minimumInteritemSpacing)
                let yOffset = columnHeights[minColumnIndex]
                
                attribute.frame.origin = CGPoint(x: xOffset, y: yOffset)
                columnHeights[minColumnIndex] = yOffset + attribute.frame.height + minimumLineSpacing
                
                newAttributes.append(attribute)
            } else {
                newAttributes.append(attribute)
            }
        }
        return newAttributes
    }
}

