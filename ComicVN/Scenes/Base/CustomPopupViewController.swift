//
//  CustomPopupViewController.swift
//  ComicVN
//
//  Created by Tuấn on 2/3/25.
//

import UIKit
import SnapKit

class CustomPopupViewController: UIViewController {
    
    let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel = LabelFactory.createLabel(text: "Xoá Bookmarks",
                                              font: .bold16,
                                              textColor: .black)
    let messageLabel = LabelFactory.createLabel(text: "Bạn có chắc chắn xóa toàn bộ Bookmarks chứ, hành động này không thể hoàn tác",
                                                font: .regular16,
                                                textColor: .black)
    let cancelBtn = ButtonFactory.createButton("Cancel",
                                               font: .bold16,
                                               textColor: .black,
                                               bgColor: .white)
    let okBtn = ButtonFactory.createButton("OK",
                                           font: .bold16,
                                           textColor: .black,
                                           bgColor: .white)
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#979797")
        return view
    }()
    
    var onOk: (() -> Void)?
    var onCancel: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupEvent()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(hex: "#979797", alpha: 0.5)
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
        
        containerView.addSubviews([titleLabel, messageLabel, lineView, okBtn, cancelBtn])
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(18)
        }
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().inset(33)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(31)
            make.right.equalToSuperview().inset(33)
            make.height.equalTo(1)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(13)
            make.left.equalToSuperview().offset(52)
            make.bottom.equalToSuperview().offset(-17)
        }
        
        okBtn.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(13)
            make.right.equalToSuperview().inset(75)
            make.bottom.equalToSuperview().offset(-17)
        }
    }
    
    func setupEvent() {
        okBtn.addTarget(self, action: #selector(okBtnAction), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
    }
    
    @objc func okBtnAction() {
        self.onOk?()
        self.dismiss(animated: false)
    }
    
    @objc func cancelBtnAction() {
        self.dismiss(animated: false)
    }
    
    func configure(onOk: @escaping () -> Void) {
        self.onOk = onOk
    }
}
