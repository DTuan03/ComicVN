//
//  AuthManager.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import Foundation
import FirebaseAuth
import RxSwift

class LoginManger {
    static let shared = LoginManger()
    
    func loginUser(email: String, password: String) -> Observable<(Bool, String?, String)> {
        return Observable.create { observer in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    observer.onNext((false, error.localizedDescription, ""))
                    observer.onCompleted()
                    return
                }
                if let userId = result?.user.uid {
                    observer.onNext((true, nil, userId))
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
