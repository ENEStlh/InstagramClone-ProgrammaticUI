//
//  ViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    // Modern UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.aperture")
        imageView.tintColor = UIColor.systemPurple
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Giriş Yap", for: .normal)
        btn.backgroundColor = UIColor.systemPurple
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 16
        btn.layer.shadowColor = UIColor.systemPurple.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 8
        return btn
    }()
    
    private let signUpButton: UIButton = {
        let btn2 = UIButton(type: .system)
        btn2.setTitle("Kayıt Ol", for: .normal)
        btn2.setTitleColor(.systemPurple, for: .normal)
        btn2.backgroundColor = .white
        btn2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn2.layer.cornerRadius = 16
        btn2.layer.borderWidth = 2
        btn2.layer.borderColor = UIColor.systemPurple.cgColor
        btn2.layer.shadowColor = UIColor.systemPurple.cgColor
        btn2.layer.shadowOpacity = 0.1
        btn2.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn2.layer.shadowRadius = 6
        return btn2
    }()
    
    private let emailTextField: UITextField = {
        let etextfield = UITextField()
        etextfield.autocapitalizationType = .none
        etextfield.placeholder = "Email"
        etextfield.borderStyle = .none
        etextfield.backgroundColor = UIColor.systemGray6
        etextfield.layer.cornerRadius = 12
        etextfield.setLeftPaddingPoints(16)
        etextfield.translatesAutoresizingMaskIntoConstraints = false
        etextfield.font = UIFont.systemFont(ofSize: 16)
        return etextfield
    }()
    
    private let sifreTextField: UITextField = {
        let sifretextfield = UITextField()
        sifretextfield.autocapitalizationType = .none
        sifretextfield.placeholder = "Parola"
        sifretextfield.isSecureTextEntry = true
        sifretextfield.borderStyle = .none
        sifretextfield.backgroundColor = UIColor.systemGray6
        sifretextfield.layer.cornerRadius = 12
        sifretextfield.setLeftPaddingPoints(16)
        sifretextfield.translatesAutoresizingMaskIntoConstraints = false
        sifretextfield.font = UIFont.systemFont(ofSize: 16)
        return sifretextfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "Giriş"
        setupUI()
        setupBindings() // ViewModel bağlantısı
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
    
    private func setupUI() {
        // Remove all subviews if reloading
        view.subviews.forEach { $0.removeFromSuperview() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.withAlphaComponent(0.2).cgColor, UIColor.systemBlue.withAlphaComponent(0.2).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let stack = UIStackView(arrangedSubviews: [logoImageView, emailTextField, sifreTextField, loginButton, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            sifreTextField.heightAnchor.constraint(equalToConstant: 48),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginButton.addTarget(self, action: #selector(girisYap), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(kayitOl), for: .touchUpInside)
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

// Padding helper for UITextField
private extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
