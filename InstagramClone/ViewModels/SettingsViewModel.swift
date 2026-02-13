//
//  SettingsViewModel.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 13.02.2026.
//

import Foundation
import FirebaseAuth

class SettingsViewModel {
    
    // View Controller tarafında (success, error) beklendiği için tanımı güncelliyoruz:
    // completion: (BasariliMi, HataMesaji?)
    func signOut(completion: (Bool, String?) -> Void) {
        do {
            try Auth.auth().signOut()
            // Başarılı oldu (true), hata yok (nil)
            completion(true, nil)
        } catch {
            // Başarısız oldu (false), hatayı gönder (error.localizedDescription)
            completion(false, error.localizedDescription)
        }
    }
}
