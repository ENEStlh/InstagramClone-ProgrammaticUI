//
//  ViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    // UI Elemanları
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Giriş Yap", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let signUpButton: UIButton = {
        let btn2 = UIButton(type: .system)
        btn2.setTitle("Kayıt Ol", for: .normal)
        btn2.setTitleColor(.white, for: .normal)
        btn2.backgroundColor = .systemBlue
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn2.layer.cornerRadius = 8
        return btn2
    }()
    
    private let emailTextField: UITextField = {
        let etextfield = UITextField()
        etextfield.autocapitalizationType = .none
        etextfield.placeholder = "Email Giriniz"
        etextfield.borderStyle = .roundedRect
        etextfield.translatesAutoresizingMaskIntoConstraints = false
        return etextfield
    }()
    
    private let sifreTextField: UITextField = {
        let sifretextfield = UITextField()
        sifretextfield.autocapitalizationType = .none
        sifretextfield.placeholder = "Parola Giriniz"
        sifretextfield.isSecureTextEntry = true
        sifretextfield.borderStyle = .roundedRect
        sifretextfield.translatesAutoresizingMaskIntoConstraints = false
        return sifretextfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Giriş"
        setupUI()
        setupBindings() // ViewModel bağlantısı
        
        loginButton.addTarget(self, action: #selector(girisYap), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(kayitOl), for: .touchUpInside)
    }
    
    private func setupBindings() {
        // Başarılı olursa
        viewModel.onSuccess = { [weak self] in
            self?.anaSayfayaGec()
        }
        
        // Hata olursa
        viewModel.onError = { [weak self] errorMessage in
            self?.hata(messageInput: errorMessage, titleInpu: "HATA")
        }
    }
    
    func setupUI() {
        view.addSubview(emailTextField)
        view.addSubview(sifreTextField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        // Klavye kapatma extension'ı (Projenizde var olduğunu varsayıyorum)
        self.klavyeyiKapatmaOzelligiEkle()
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            sifreTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            sifreTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sifreTextField.widthAnchor.constraint(equalToConstant: 300),
            sifreTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: sifreTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: sifreTextField.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func anaSayfayaGec() {
        guard let window = view.window else { return }
        UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: {
            window.rootViewController = MainTabBarController()
        }, completion: nil)
    }
    
    func hata(messageInput: String, titleInpu: String) {
        let alert = UIAlertController(title: titleInpu, message: messageInput, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .destructive)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    @objc func girisYap() {
        viewModel.authenticate(email: emailTextField.text ?? "", password: sifreTextField.text ?? "", isSignUp: false)
    }
    
    @objc func kayitOl() {
        viewModel.authenticate(email: emailTextField.text ?? "", password: sifreTextField.text ?? "", isSignUp: true)
    }
}
