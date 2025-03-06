//
//  SignUpViewController.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController, NavigationViewDelegate {
    func didTapLeftButton(in view: UIView) {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapRightAddButton(in view: UIView) {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    private let viewModel = SignUpViewModel()
    lazy var navigationView = {
         NavigationViewFactory.createSecondNavigationView(leftImage: .arrowLeft,
                                                          titleButton: "back",
                                                          delegate: self)
    }()
    lazy var scrollView = ScrollViewFactory.createScrollView(showsVerticalScrollIndicator: true,
                                                             bounces: false)
    lazy var contentView = UIView()
    lazy var logoImageView = ImageViewFactory.createImageView(image: UIImage(named: "avartar"),
                                                              contentMode: .scaleAspectFit)
    lazy var nameTextField: UITextField = {
        let textField = TextFieldFactory.createTextField(placeholder: "name",
                                                         font: .medium18,
                                                         textAlignment: .left,
                                                         rounded: true,
                                                         height: 48)
        textField.imageLeftView(image: "", placeholder: "email")
        return textField
    }()

    lazy var emailTextField: UITextField = {
        let textField = TextFieldFactory.createTextField(placeholder: "email",
                                                         font: .medium18,
                                                         rounded: true,
                                                         height: 48)
        textField.imageLeftView(image: "", placeholder: "email")
        return textField
    }()
    lazy var passTextField: UITextField = {
       let textField = TextFieldFactory.createTextField(placeholder: "password",
                                                        font: .medium18,
                                                        textAlignment: .left,
                                                        rounded: true,
                                                        height: 48)
        textField.imageLeftView(image: "", placeholder: "passWord")
        textField.imageRightView(image: "eyes", placeholder: "")
        return textField
    }()
    lazy var signUpButton = ButtonFactory.createButton("signUp",
                                                       rounded: true)
    lazy var acceptTermsLabel: UILabel = {
        let label = LabelFactory.createLabel(text: "acceptTerms",
                                             font: .regular14,
                                             textColor: UIColor(hex: "#434040"),
                                             textAlignment: .center)
        label.highlightText(
            fullText: NSLocalizedString("acceptTerms", comment: ""),
            highlightTexts: [NSLocalizedString("termsHighLine", comment: ""), NSLocalizedString("conditionsHighLine", comment: "")],
            highlightColor: UIColor(hex: "#FF7B00")
        )
        return label
    }()
    lazy var orLoginLabel = LabelFactory.createLabel(text: "orLoginWithSocialMedia",
                                                     font: .regular16,
                                                     textColor: UIColor(hex: "#434040"),
                                                     textAlignment: .center)
    lazy var googleButton = {
        let btn =  ButtonFactory.createButton("googleLogin", image: UIImage(named: "logoGG"), font: .medium16, textColor: .black, bgColor: UIColor(hex: "#F6F6F6"), rounded: true)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 21)
        return btn
    }()
   
    lazy var appleButton = ButtonFactory.createButton("appleLogin", font: .medium16, textColor: .white, bgColor: UIColor(hex: "#3B5998"), rounded: true)
    lazy var faceBookButton = ButtonFactory.createButton("facebookLogin", font: .medium16, textColor: .white, bgColor: UIColor(hex: "#000000"), rounded: true)
    lazy var signUpLabel = LabelFactory.createLabel(text: "alreadyHaveAccount", font: .bold18, textAlignment: .center)
    
    lazy var stackViewTextField = [nameTextField, emailTextField, passTextField].vStack(10, alignment: .fill, distribution: .fill)
    
    lazy var stackViewSignOther = [googleButton, faceBookButton, appleButton].vStack(12, alignment: .fill, distribution: .fillEqually)
    
    override func setupUI() {
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(1)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        contentView.addSubviews([logoImageView, stackViewTextField, signUpButton, acceptTermsLabel, orLoginLabel, stackViewSignOther, signUpLabel])
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
    
        stackViewTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(48)
            make.left.right.equalToSuperview().inset(32)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(stackViewTextField.snp.bottom).offset(63)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(48)
        }
        
        acceptTermsLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        orLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(acceptTermsLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        stackViewSignOther.snp.makeConstraints { make in
            make.top.equalTo(orLoginLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(32)
            make.height.equalTo(138)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(stackViewSignOther.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupEvent() {
        signUpButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let name = nameTextField.text
            let email = emailTextField.text
            let password = passTextField.text
            guard let email = email, !email.isEmpty,
                  let password = password, !password.isEmpty else {
                UIAlertFactory.showAlert(on: self, message: "Email hoặc mật khẩu không được để trống")
                return
            }
            
            if (viewModel.isValidEmail(email) && viewModel.isValidPassword(password)) {
                viewModel.registerUser(email: emailTextField.text ?? "", password: passTextField.text ?? "")
                viewModel.isRegistered
                    .subscribe(onNext: { [weak self] success, error, userId in
                        guard let self = self else {return}
                        if success {
                            viewModel.saveUser(userId: userId ?? "", email: email, name: name ?? "")
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            UIAlertFactory.showAlert(on: self, message: "Đăng ký thất bại rồi! 😜😜😜")
                        }
                    })
                    .disposed(by: disposeBag)
            } else {
                UIAlertFactory.showAlert(on: self, message: "Kiểm tra lại email và mật khẩu. Mật khẩu phải từ 8 ký tự gồm 1 hoa và số")
            }
        })
        .disposed(by: disposeBag)
        
        let signUpLabelTap = UITapGestureRecognizer(target: self, action: #selector(navigationSignIn))
        signUpLabel.addGestureRecognizer(signUpLabelTap)
    }
    
    @objc func navigationSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    func registerUser(email: String, password: String) {
        viewModel.registerUser(email: email, password: password)
    }
}
