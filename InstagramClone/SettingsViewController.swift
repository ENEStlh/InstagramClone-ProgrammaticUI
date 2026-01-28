//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {
    private let signOutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Çıkış Yap", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = " Settings"
        
        
    }
    
    func setupUI(){
        view.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        signOutButton.addTarget(self, action: #selector(cikisYap), for: .touchUpInside)
    }
 @objc   func cikisYap(){
        do {
            try Auth.auth().signOut()
            guard let window = view.window else { return  }
            let loginVC = UINavigationController(rootViewController: LoginViewController())
            
            UIView.transition(with: window, duration: 0.5,options: .transitionFlipFromLeft, animations: {
                window.rootViewController = loginVC
            },completion: nil)
            
            
            
        } catch  {
            print("çıkıs hatası")
        }
    }
   

}
