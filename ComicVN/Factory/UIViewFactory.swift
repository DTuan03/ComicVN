//
//  UIViewFactory.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

import UIKit
import SnapKit

class UIViewFactory {
    
    static func createLineView() -> UIView {
        let screenWidth = UIScreen.main.bounds.width
        
        let lineView = UIView()
//        lineView.frame.size.height = 0.5
        lineView.frame.size.width = screenWidth
        lineView.backgroundColor = UIColor(hex: "#E8E7E7")
        
        return lineView
    }
}
