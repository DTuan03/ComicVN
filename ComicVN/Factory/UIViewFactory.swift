//
//  UIViewFactory.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

import UIKit

class UIViewFactory {
    
    static func createLineView() -> UIView {
        let screenWidth = UIScreen.main.bounds.width
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 1))
        lineView.backgroundColor = UIColor(hex: "#E8E7E7")
        
        return lineView
    }
}
