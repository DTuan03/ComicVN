//
//  NavigationView.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//
import UIKit
import SnapKit

class NavigationViewFactory {
    static func createNavigationView(leftImage: UIImage? = nil, title: String, right1Image: UIImage? = nil, right2Image: UIImage? = nil) -> UIView {
        let view = UIView()
//        view.backgroundColor = .blue
        view.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        let leftButton = createButton(withImage: leftImage)
        let titleLabel = LabelFactory.createLabel(text: title, font: UIFont.bold18, textColor: .black, textAlignment: .center)
        
        let right1Button = createButton(withImage: right1Image)
        let right2Button = createButton(withImage: right2Image)
        
        let lineView = UIViewFactory.createLineView()
        
        view.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(22)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [right1Button, right2Button])
        stackView.axis = .horizontal
        stackView.spacing = 11
        stackView.distribution = .fill
        stackView.alignment = .fill
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(7)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return view
    }
    
    private static func createButton(withImage image: UIImage?) -> UIButton {
        let button = UIButton()
        guard let image = image else { return button }
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.tintColor = UIColor(hex: "#FF7B00")
        return button
    }
}
