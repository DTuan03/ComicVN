//
//  NavigationView.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//
import UIKit
import SnapKit

protocol NavigationViewDelegate: AnyObject {
    func didTapLeftButton(in view: UIView)
    func didTapRightAddButton(in view: UIView)
}

class NavigationViewFactory {
    static func createMainNavigationView(leftImage: UIImage? = nil,
                                     title: String? = nil,
                                     right1Image: UIImage? = nil,
                                     right2Image: UIImage? = nil,
                                     delegate: NavigationViewDelegate? = nil) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        let leftButton = createButton(withImage: leftImage)
        
        
        let right1Button = createButton(withImage: right1Image)
        let right2Button = createButton(withImage: right2Image)
        
        let lineView = UIViewFactory.createLineView()
        
        leftButton.addTargetClosure { _ in
            delegate?.didTapLeftButton(in: view)
        }
        
        right1Button.addTargetClosure { _ in
            delegate?.didTapRightAddButton(in: view)
        }
        
        view.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(22)
        }
        
        if let title = title {
            let titleLabel = LabelFactory.createLabel(text: title, font: UIFont.bold18, textColor: .black, textAlignment: .center)
            view.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
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
    
    static func createSecondNavigationView(leftImage: UIImage? = nil,
                                     titleButton: String? = nil,
                                     delegate: NavigationViewDelegate? = nil) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        let leftButton = createButton(withImage: leftImage, title: titleButton)
        leftButton.contentHorizontalAlignment = .left
        let lineView = UIViewFactory.createLineView()
        
        leftButton.addTargetClosure { _ in
            delegate?.didTapLeftButton(in: view)
        }
        
        view.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview()
        }
        
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.bottom).offset(7)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }
        
        return view
    }
    
    private static func createButton(withImage image: UIImage?, title: String? = nil) -> UIButton {
        let button = UIButton()
        guard let image = image else { return button }
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor(hex: "#FF7B00")
        if let titleButton = title {
            button.setTitle(NSLocalizedString(titleButton, comment: ""), for: .normal)
            button.setTitleColor(UIColor(hex: "#FF7B00"), for: .normal)
            button.titleLabel?.font = UIFont.bold18
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        }
        return button
    }
}
