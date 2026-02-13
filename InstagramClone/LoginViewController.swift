//
//  ViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    
    //UI ELEMANLARI
    private let loginButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Giriş Yap", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let signUpButton = {
        let btn2 = UIButton(type: .system)
        btn2.setTitle("Kayıt Ol", for: .normal)
        btn2.setTitleColor(.white, for: .normal)
        btn2.backgroundColor = .systemBlue
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn2.layer.cornerRadius = 8
        return btn2
    }()
    
    private let emailTextField = {
        let etextfield = UITextField()
        etextfield.autocapitalizationType = .none
        etextfield.placeholder = "Email Giriniz"
        etextfield.borderStyle = .roundedRect
        etextfield.translatesAutoresizingMaskIntoConstraints = false
        return etextfield
    }()
    
    private let sifreTextField = {
        let sifretextfield = UITextField()
        sifretextfield.autocapitalizationType = .none
        sifretextfield.placeholder = "Parola Giriniz"
        sifretextfield.borderStyle = .roundedRect
        sifretextfield.translatesAutoresizingMaskIntoConstraints = false
        return sifretextfield
    }()
    // LİFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Giriş"
        
        setupUI()
        loginButton.addTarget(self, action: #selector(girisYap), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(kayıtOl), for: .touchUpInside)
        
        
    }
    
    // UI YERLEŞİMİ(NATİVE AUTO LAYOUT)
    
    func setupUI(){
        view.addSubview(emailTextField)
        view.addSubview(sifreTextField)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor,),
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
    
    func anaSayfayaGec(){
        guard let window = view.window else {return}
        // Root değiştirme animasyonu
        UIView.transition(with: window, duration: 0.5,options: .curveEaseInOut, animations:{
            window.rootViewController = MainTabBarController()
        },completion: nil)
    }
    
   @objc func girisYap(){
        if   emailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.sifreTextField.text!){(result, error) in
                
                if error != nil {
                    self.hata(messageInput: error?.localizedDescription ?? "HATA", titleInpu: "HATA")
                }
                else{
                    self.anaSayfayaGec()
                }
                
                
                
            }
            
            
            
        }
        else{
            hata(messageInput: "Emaili ve Şifreyi Boş Bırakmayınız", titleInpu: "HATA")
        }
        
    }
    func hata(messageInput:String,titleInpu:String){
        let alert = UIAlertController(title: titleInpu, message: messageInput, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Tamam", style: .destructive)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
 @objc   func kayıtOl(){
        if   emailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.sifreTextField.text!){(result, error) in
                
                if error != nil {
                    self.hata(messageInput: error?.localizedDescription ?? "HATA", titleInpu: "HATA")
                }
                else{
                    self.anaSayfayaGec()
                }
                
                
                
            }
            
            
            
        }
        else{
            hata(messageInput: "Emaili ve Şifreyi Boş Bırakmayınız", titleInpu: "HATA")
        }
        
        
    }
    
}
