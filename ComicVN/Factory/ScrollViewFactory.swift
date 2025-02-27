//
//  ScrollViewFactory.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit
class ScrollViewFactory {
    static func createScrollView(backgroundColor: UIColor = .white, isPagingEnabled: Bool = false, showsVerticalScrollIndicator: Bool = false, showsHorizontalScrollIndicator: Bool = false, bounces: Bool = true) -> UIScrollView {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = backgroundColor
        scrollView.isPagingEnabled = isPagingEnabled
        scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        scrollView.bounces = bounces
        
        return scrollView
    }
}
