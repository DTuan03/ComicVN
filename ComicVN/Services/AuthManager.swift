//
//  AuthManager.swift
//  ComicVN
//
//  Created by Tuấn on 3/3/25.
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
    
//    func signInWithGoogle(presenting viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
//        guard let clientID = FirebaseApp.app()?.options.clientID else {
//            completion(.failure(NSError(domain: "Firebase", code: 0, userInfo: [NSLocalizedDescriptionKey: "Không tìm thấy Client ID"])))
//            return
//        }
//        
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//        
//        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
//                completion(.failure(NSError(domain: "Google SignIn", code: 0, userInfo: [NSLocalizedDescriptionKey: "Không thể lấy ID Token"])))
//                return
//            }
//            
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
//            
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    completion(.failure(error))
//                } else if let user = authResult?.user {
//                    completion(.success(user))
//                }
//            }
//        }
//    }
}
