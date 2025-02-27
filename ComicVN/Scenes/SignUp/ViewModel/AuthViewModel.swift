//
//  AuthViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import RxSwift

class AuthViewModel {
    private let authManager = AuthManager.shared
    private let disposeBag = DisposeBag()
    
    var isRegistered = PublishSubject<(Bool, String?, String?)>()
    var isLoggedIn = PublishSubject<(Bool, String?, String)>()
    
    func registerUser(email: String, password: String) {
        authManager.registerUser(email: email, password: password)
            .subscribe(onNext: { [weak self] success, errorMessage, userId in
                self?.isRegistered.onNext((success, errorMessage, userId))
            })
            .disposed(by: disposeBag)
    }
}
