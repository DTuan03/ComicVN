//
//  ForgotViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 13/3/25.
//

import FirebaseAuth

class ForgotViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func sendResetPassword(email: String) -> Bool {
        var succes: Bool?
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                succes = false
            } else {
                succes = true
            }
        }
        return succes ?? false
    }
}
