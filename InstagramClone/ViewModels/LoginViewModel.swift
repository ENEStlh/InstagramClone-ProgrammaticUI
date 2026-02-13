//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 13.02.2026.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func authenticate(email: String, password: String, isSignUp: Bool) {
        if email.isEmpty || password.isEmpty {
            onError?("Emaili ve Şifreyi Boş Bırakmayınız")
            return
        }
        
        if isSignUp {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
                if let error = error { self?.onError?(error.localizedDescription) }
                else { self?.onSuccess?() }
            }
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
                if let error = error { self?.onError?(error.localizedDescription) }
                else { self?.onSuccess?() }
            }
        }
    }
}
