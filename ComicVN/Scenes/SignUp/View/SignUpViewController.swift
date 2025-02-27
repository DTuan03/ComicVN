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

class SignUpViewController: BaseViewController {
    private let viewModel = AuthViewModel()
    let viewNavigation: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#DCDBDB")
        return view
    }()
    let backButton = ButtonFactory.createButton(" Trở về", image: UIImage(systemName: "chevron.left"), font: .regular18 , textColor: UIColor(hex: "#FF7B00"), bgColor: .white, rounded: false, height: 24)
    let scrollView = ScrollViewFactory.createScrollView(showsVerticalScrollIndicator: true, bounces: false)
    let contentView = UIView()
    let logoImageView = ImageViewFactory.createImageView(image: UIImage(named: "avartar"), contentMode: .scaleAspectFit)
    let nameTextField = TextFieldFactory.createTextField(placeholder: "Tên", font: .medium18, textAlignment: .left, rounded: true, height: 48)
    let emailTextField = TextFieldFactory.createTextField(placeholder: "Email", font: .medium18, textAlignment: .left, rounded: true, height: 48)
    let passTextField = TextFieldFactory.createTextField(placeholder: "Mật khẩu", font: .medium18, textAlignment: .left, rounded: true, height: 48)
    let signUpButton = ButtonFactory.createButton("Đăng ký", rounded: true, height: 48)
    let acceptTermsLabel = LabelFactory.createLabel(text: "Bằng cách xác nhận, bạn đồng ý với các \n Điều Khoản và Điều kiện của chúng tôi", font: .regular14, textColor: UIColor(hex: "#434040"), textAlignment: .center)
    let orLoginLabel = LabelFactory.createLabel(text: "hoặc Đăng nhập bằng mạng xã hội", font: .regular16, textColor: UIColor(hex: "#434040"), textAlignment: .center)
    let googleButton = ButtonFactory.createButton("Đăng nhập bằng Google", image: UIImage(named: "logoGG"), font: .medium16, textColor: .black, bgColor: UIColor(hex: "#F6F6F6"), rounded: true, height: 38)
    let appleButton = ButtonFactory.createButton("Đăng nhập bằng Apple", font: .medium16, textColor: .white, bgColor: UIColor(hex: "#3B5998"), rounded: true, height: 38)
    let faceBookButton = ButtonFactory.createButton("Đăng nhập bằng Facebook", font: .medium16, textColor: .white, bgColor: UIColor(hex: "#000000"), rounded: true, height: 38)
    let signUpLabel = LabelFactory.createLabel(text: "Tôi đã có tài khoản", font: .bold18, textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupEvent()
        viewModel.isRegistered
            .subscribe(onNext: { [weak self] success, errorMessage, userId in
                if success {
                    print("Đăng ký thành công với userId: \(userId ?? "")")
                    let loginVC = LoginViewController()
                    loginVC.modalTransitionStyle = .crossDissolve
                    loginVC.modalPresentationStyle = .fullScreen
                    self?.present(loginVC, animated: true)
                } else {
                    print("Lỗi đăng ký: \(errorMessage ?? "")")
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.left.equalToSuperview().offset(48)
        }
        
        view.addSubview(viewNavigation)
        viewNavigation.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(5.66)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(viewNavigation.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
        }
        
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34.34)
            make.centerX.equalToSuperview()
        }
        emailTextField.imageLeftView(image: "", placeholder: "email")
        passTextField.imageLeftView(image: "", placeholder: "passWord")
        nameTextField.imageLeftView(image: "", placeholder: "email")
        passTextField.imageRightView(image: "eyes", placeholder: "")
        let stackViewTextField = [nameTextField, emailTextField, passTextField].vStack(10, alignment: .fill, distribution: .fill)
        contentView.addSubview(stackViewTextField)
        stackViewTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50.14)
            make.left.right.equalToSuperview().inset(34)
        }
        contentView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(stackViewTextField.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(30)
        }
        contentView.addSubview(acceptTermsLabel)
        acceptTermsLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
        }
        acceptTermsLabel.highlightText(
            fullText: "Bằng cách xác nhận, bạn đồng ý với các \n Điều Khoản và Điều kiện của chúng tôi",
            highlightTexts: ["Điều Khoản", "Điều kiện của chúng tôi"],
            highlightColor: UIColor(hex: "#FF7B00")
        )
        
        contentView.addSubview(orLoginLabel)
        orLoginLabel.snp.makeConstraints { make in
            make.top.equalTo(acceptTermsLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        let stackViewSignOther = [googleButton, faceBookButton, appleButton].vStack(12, alignment: .fill, distribution: .fill)
        contentView.addSubview(stackViewSignOther)
        stackViewSignOther.snp.makeConstraints { make in
            make.top.equalTo(orLoginLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(34)
        }
        contentView.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(stackViewSignOther.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupEvent() {
        signUpButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            guard let email = emailTextField.text, !email.isEmpty,
                  let password = passTextField.text, !password.isEmpty else {
                UIAlertFactory.showAlert(on: self, message: "Email hoặc mật khẩu không được để trống")
                return
            }
            viewModel.registerUser(email: emailTextField.text ?? "", password: passTextField.text ?? "")
        })
        .disposed(by: disposeBag)
        
        backButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            navigationController?.popViewController(animated: true)
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
