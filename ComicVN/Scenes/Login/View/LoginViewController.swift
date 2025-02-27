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
    
    let imageView = ImageViewFactory.createImageView(image: UIImage(named: "avartar"), contentMode: .scaleAspectFit)
    let emailTextField = TextFieldFactory.createTextField(placeholder: "Email", font: .medium18, textAlignment: .left, rounded: true, height: 48)
    let passTextField = TextFieldFactory.createTextField(placeholder: "Mật khẩu", font: .medium18, textAlignment: .left, rounded: true, height: 48)
    let loginButton = ButtonFactory.createButton("Đăng nhập", rounded: true, height: 48)
    let forgotPassLabel = LabelFactory.createLabel(text: "Quên mật khẩu?", font: .regular16, textColor: UIColor(hex: "#FF7B00"), textAlignment: .center)
    let orLoginLabel = LabelFactory.createLabel(text: "hoặc Đăng nhập bằng mạng xã hội", font: .regular16, textColor: UIColor(hex: "#434040"), textAlignment: .center)
    let googleButton = ButtonFactory.createButton("Đăng nhập bằng Google", image: UIImage(named: "logoGG"), font: .medium16, textColor: .black, bgColor: UIColor(hex: "#F6F6F6"), rounded: true, height: 48)
    let appleButton = ButtonFactory.createButton("Đăng nhập bằng Apple", font: .medium16, textColor: .white, bgColor: UIColor(hex: "#3B5998"), rounded: true, height: 38)
    let faceBookButton = ButtonFactory.createButton("Đăng nhập bằng Facebook", font: .medium16, textColor: .white, bgColor: UIColor(hex: "#000000"), rounded: true, height: 38)
    let signUpLabel = LabelFactory.createLabel(text: "Đăng ký", font: .bold18, textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.isLoggedIn
            .subscribe(onNext: { [weak self] success, errorMessage, userId in
                if success {
                    print("Đăng nhập thành công với userId: \(userId)")
                } else {
                    print("Lỗi đăng nhập: \(errorMessage ?? "")")
                }
            })
            .disposed(by: disposeBag)
    }
    override func setupUI() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(97)
            make.centerX.equalToSuperview()
        }
        emailTextField.imageLeftView(image: "", placeholder: "email")
        passTextField.imageLeftView(image: "", placeholder: "passWord")
        passTextField.imageRightView(image: "eyes", placeholder: "")
        let stackViewTextField = [emailTextField, passTextField].vStack(14, alignment: .fill, distribution: .fill)
        view.addSubview(stackViewTextField)
        stackViewTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(60.14)
            make.left.right.equalToSuperview().inset(33)
        }
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackViewTextField.snp.bottom).offset(29)
            make.left.right.equalToSuperview().inset(30)
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
        let stackViewSignOther = [googleButton, faceBookButton, appleButton].vStack(12, alignment: .fill, distribution: .fill)
        view.addSubview(stackViewSignOther)
        stackViewSignOther.snp.makeConstraints { make in
            make.top.equalTo(orLoginLabel.snp.bottom).offset(35)
            make.left.right.equalToSuperview().inset(30)
        }
        
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(stackViewSignOther.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    override func setupEvent() {
        let signUpLabelTap = UITapGestureRecognizer(target: self, action: #selector(navigationToSignUp))
        signUpLabel.addGestureRecognizer(signUpLabelTap)
        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    //MARK: - Chuyen man hinh sang dang nhap
    @objc func navigationToSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func signIn() {
        self.view.endEditing(true)
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passTextField.text, !password.isEmpty else {
            UIAlertFactory.showAlert(on: self, message: "Email hoặc mật khẩu không được để trống")
            return
        }
        viewModel.loginUser(email: emailTextField.text ?? "", password: passTextField.text ?? "")
    }
}
