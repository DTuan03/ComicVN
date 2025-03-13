//
//  ForgotViewController.swift
//  ComicVN
//
//  Created by Tuấn on 13/3/25.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ForgotViewController: BaseViewController {
    let viewModel = ForgotViewModel()
    lazy var navigationView = {
        NavigationViewFactory.createSecondNavigationView(leftImage: .arrowLeft,
                                                         titleButton: "back",
                                                         delegate: self)
    }()
    
    lazy var logoImageView = ImageViewFactory.createImageView(image: UIImage(named: "avartar"),
                                                              contentMode: .scaleAspectFit)
    lazy var emailTextField: UITextField = {
        let textField = TextFieldFactory.createTextField(placeholder: "Email",
                                                         font: .medium18,
                                                         textAlignment: .left,
                                                         rounded: true)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var confirmButton = ButtonFactory.createButton("Xác nhận",
                                                        rounded: true)
    
    override func setupUI() {
        view.addSubviews([navigationView, logoImageView, emailTextField, confirmButton])
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(48)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(48)
        }
    }
    
    override func setupEvent() {
        confirmButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let email = emailTextField.text
            guard let email = email, !email.isEmpty else {
                UIAlertFactory.showAlert(on: self, message: "Email không được để trống")
                return
            }
            
            if viewModel.isValidEmail(email) {
                if !viewModel.sendResetPassword(email: email) {
                    navigationController?.popViewController(animated: true)
                } else {
                    UIAlertFactory.showAlert(on: self, message: "Hãy kiểm tra lại email nhé!")
                }
            } else {
                UIAlertFactory.showAlert(on: self, message: "Email không đúng định dạng")
                return
            }
        })
        .disposed(by: disposeBag)
    }
    
    @objc func navigationSignIn() {
        navigationController?.popViewController(animated: true)
    }
}

extension ForgotViewController: NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        navigationController?.popViewController(animated: true)
    }
    func didTapRightSearchButton(in view: UIView) {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func didTapRightAddButton(in view: UIView) {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
}
