//
//  Untitled.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import Foundation
import FirebaseAuth
import RxSwift

class AuthManager {
    static let shared = AuthManager()
    
    func registerUser(email: String, password: String) -> Observable<(Bool, String?, String?)> {
        return Observable.create { observer in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    observer.onNext((false, error.localizedDescription, nil))
                    observer.onCompleted()
                    return
                }
                
                if let userId = result?.user.uid {
                    observer.onNext((true, nil, userId))
                } else {
                    observer.onNext((false, nil, "Không lấy được userId"))
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
