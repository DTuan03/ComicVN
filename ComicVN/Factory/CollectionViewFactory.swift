//
//  CollectionView.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit

class CollectionViewFactory {
    static func createCollectionView(scrollDirection: UICollectionView.ScrollDirection = .horizontal, minimumInteritemSpacing: CGFloat = 6, estimated: Bool = true, top: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumInteritemSpacing = minimumInteritemSpacing
//        layout.itemSize = CGSize(width: width, height: height)
        if estimated {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        layout.sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }
}
