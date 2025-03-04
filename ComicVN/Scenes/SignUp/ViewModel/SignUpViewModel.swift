//
//  AuthViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import RxSwift

class SignUpViewModel {
    private let authManager = AuthManager.shared
    private let disposeBag = DisposeBag()
    
    var isRegistered = PublishSubject<(Bool, String?, String?)>()
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func registerUser(email: String, password: String) {
        authManager.registerUser(email: email, password: password)
            .subscribe(onNext: { [weak self] success, errorMessage, userId in
                self?.isRegistered.onNext((success, errorMessage, userId))
            })
            .disposed(by: disposeBag)
    }
}
