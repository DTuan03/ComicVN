//
//  AuthViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import RxSwift

class LoginViewModel {
    private let loginManager = AuthManager.shared
    private let disposeBag = DisposeBag()
    
    var isLoggedIn = PublishSubject<(Bool, String?, String)>()
    
    func loginUser(email: String, password: String) {
        loginManager.loginUser(email: email, password: password)
            .subscribe(onNext: { [weak self] success, errorMessage, userId in
                self?.isLoggedIn.onNext((success, errorMessage, userId))
            })
            .disposed(by: disposeBag)
    }
}
