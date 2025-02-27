//
//  CustomNavigationController.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(viewControllers.count)
        if viewControllers.count > 1 {
            addBottomBorderToNavigationBar()
        } else {
            removeBottomBorderFromNavigationBar()
        }
    }

    private func addBottomBorderToNavigationBar() {
        let borderLayer = CALayer()

        borderLayer.frame = CGRect(
            x: 0,
            y: navigationBar.frame.size.height - 1,
            width: navigationBar.frame.size.width,
            height: 1
        )
        
        borderLayer.backgroundColor = UIColor.gray.cgColor
        
        navigationBar.layer.addSublayer(borderLayer)
    }
    
    private func removeBottomBorderFromNavigationBar() {
        if let sublayers = navigationBar.layer.sublayers {
            for layer in sublayers {
                layer.removeFromSuperlayer()
            }
        }
    }
}
