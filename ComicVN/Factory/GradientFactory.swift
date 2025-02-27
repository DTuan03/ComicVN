//
//  GradientFactory.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

import UIKit

class GradientFactory {
    
    // Hàm tạo Gradient từ 2 màu sắc
    static func gradientLayer(fromColor color1: UIColor, toColor color2: UIColor, frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [color1.cgColor, color2.cgColor]  // Màu bắt đầu và kết thúc
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // Điểm bắt đầu (trái trên)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)    // Điểm kết thúc (phải dưới)
        return gradientLayer
    }
    
    // Hàm tạo Gradient với nhiều màu
    static func gradientLayer(colors: [UIColor], frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors.map { $0.cgColor }  // Chuyển đổi mảng màu thành cgColor
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // Điểm bắt đầu (trái trên)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)    // Điểm kết thúc (phải dưới)
        return gradientLayer
    }
    
    // Hàm tạo Gradient theo chiều dọc (vertical)
    static func verticalGradientLayer(fromColor color1: UIColor, toColor color2: UIColor, frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [color1.cgColor, color2.cgColor]  // Màu bắt đầu và kết thúc
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // Điểm bắt đầu (trái trên)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)    // Điểm kết thúc (dưới)
        return gradientLayer
    }
    
    // Hàm tạo Gradient theo chiều ngang (horizontal)
    static func horizontalGradientLayer(fromColor color1: UIColor, toColor color2: UIColor, frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [color1.cgColor, color2.cgColor]  // Màu bắt đầu và kết thúc
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // Điểm bắt đầu (trái trên)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)    // Điểm kết thúc (phải trên)
        return gradientLayer
    }
}
