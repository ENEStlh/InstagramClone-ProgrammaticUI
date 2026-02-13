//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let viewModel = SettingsViewModel()
    
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
        view.backgroundColor = .systemBackground
        title = "Settings"
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        signOutButton.addTarget(self, action: #selector(cikisYap), for: .touchUpInside)
    }
    
    @objc func cikisYap() {
        viewModel.signOut { [weak self] success, error in
            if success {
                guard let window = self?.view.window else { return }
                
                // Root ViewController değiştirme (Login ekranına dönüş)
                let loginVC = UINavigationController(rootViewController: LoginViewController())
                
                UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    window.rootViewController = loginVC
                }, completion: nil)
                
            } else {
                print("Çıkış Hatası: \(error ?? "Bilinmiyor")")
            }
        }
    }
}
