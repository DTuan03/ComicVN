//
//  LoginViewController.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit
import SnapKit
import RxSwift

class LoginViewController: BaseViewController {
    private let viewModel = LoginViewModel()
    
    // MARK: UI
    let imageView = ImageViewFactory.createImageView(image: UIImage(named: "avartar"),
                                                     contentMode: .scaleAspectFit)
    
    lazy var emailTextField: UITextField = {
        let textField = TextFieldFactory.createTextField(placeholder: "email",
                                                         font: .medium18,
                                                         rounded: true)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    lazy var passTextField: UITextField = {
        let textField = TextFieldFactory.createTextField(placeholder: "password",
                                                         font: .medium18,
                                                         rounded: true)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.imageRightView(image: "eyebrow", placeholder: "")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton = ButtonFactory.createButton("login",
                                                 rounded: true)
    let forgotPassLabel = LabelFactory.createLabel(text: "forgotPassword",
                                                   font: .regular16,
                                                   textColor: UIColor(hex: "#FF7B00"),
                                                   textAlignment: .center)
    let orLoginLabel = LabelFactory.createLabel(text: "orLoginWithSocialMedia",
                                                font: .regular16,
                                                textColor: .textSecondaryColor,
                                                textAlignment: .center)
    let googleButton: UIButton = {
        let btn = ButtonFactory.createButton("googleLogin",
                                             image: UIImage(named: "logoGG"),
                                             font: .medium16,
                                             textColor: .black,
                                             bgColor: UIColor(hex: "#F6F6F6"),
                                             rounded: true)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 21)
        return btn
    }()
    let appleButton = ButtonFactory.createButton("appleLogin",
                                                 font: .medium16,
                                                 textColor: .white,
                                                 bgColor: UIColor(hex: "#3B5998"),
                                                 rounded: true)
    let faceBookButton = ButtonFactory.createButton("facebookLogin",
                                                    font: .medium16,
                                                    textColor: .white,
                                                    bgColor: UIColor(hex: "#000000"),
                                                    rounded: true)
    let signUpLabel = LabelFactory.createLabel(text: "signUp",
                                               font: .bold18,
                                               textAlignment: .center)
    
    lazy var stackViewTextField = [emailTextField, passTextField].vStack(14, alignment: .fill, distribution: .fill)
    
    lazy var stackViewSignOther = [googleButton, faceBookButton, appleButton].vStack(12, distribution: .fillEqually)
    
    // MARK: SETUP UI
    override func setupUI() {
        view.backgroundColor = .backgroundColor
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(97)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(stackViewTextField)
        stackViewTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(60.14)
            make.left.right.equalToSuperview().inset(33)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        passTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackViewTextField.snp.bottom).offset(29)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(48)
        }
        view.addSubview(forgotPassLabel)
        forgotPassLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
        }
        view.addSubview(orLoginLabel)
        orLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(forgotPassLabel.snp.bottom).offset(61)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(stackViewSignOther)
        stackViewSignOther.snp.makeConstraints { make in
            make.top.equalTo(orLoginLabel.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(138)
        }
        
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(stackViewSignOther.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    // MARK: SET up event
    override func setupEvent() {
        let signUpLabelTap = UITapGestureRecognizer(target: self, action: #selector(navigationToSignUp))
        signUpLabel.addGestureRecognizer(signUpLabelTap)
        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        let forgotPassLabelTap = UITapGestureRecognizer(target: self, action: #selector(navigationToForgot))
        forgotPassLabel.addGestureRecognizer(forgotPassLabelTap)
        
//        googleButton.rx.tap.subscribe(onNext: { [weak self] in
//            guard let self = self else { return }
//            AuthManager.shared.signInWithGoogle(presenting: self, completion: { result in
//                switch result {
//                case .success(let user):
//                    UserDefaults.standard.set(user.userId, forKey: "userId")
//                    navigationController?.pushViewController(HomeViewController(), animated: true)
//                case .failure(let error):
//                    UIAlertFactory.showAlert(on: self, message: "Đăng nhập thất bại rồi!")
//                }}
//            )
//        })
    }
    
    // MARK: Chuyen man hinh sang dang ky
    @objc func navigationToSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    // MARK: Chuyen man hinh sang quen mat khau
    @objc func navigationToForgot() {
        let forgotVC = ForgotViewController()
        navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @objc func signIn() {
        self.view.endEditing(true)
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passTextField.text, !password.isEmpty else {
            UIAlertFactory.showAlert(on: self, message: "Email hoặc mật khẩu không được để trống")
            return
        }
        viewModel.loginUser(email: emailTextField.text ?? "", password: passTextField.text ?? "")
        
        viewModel.isLoggedIn
            .subscribe(onNext: { [weak self] success, error, userId in
                guard let self = self else {return}
                if success {
                    UserDefaults.standard.set(userId, forKey: "userId")
                    navigationController?.pushViewController(HomeViewController(), animated: true)
                } else {
                    UIAlertFactory.showAlert(on: self, message: "Đăng nhập thất bại rồi! 😜😜😜")
                }
            })
            .disposed(by: disposeBag)
    }
}
