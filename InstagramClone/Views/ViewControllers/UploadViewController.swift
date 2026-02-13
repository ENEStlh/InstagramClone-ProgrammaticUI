//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let viewModel = UploadViewModel()
    
    // UI Elements
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "Image") // Assets'te bu isimde bir placeholder olmalı
        imageview.contentMode = .scaleAspectFit
        imageview.tintColor = .darkGray
        imageview.isUserInteractionEnabled = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let yorumTextField: UITextField = {
        let yorum = UITextField()
        yorum.placeholder = "Yorumunuzu Yazınız"
        yorum.borderStyle = .roundedRect
        yorum.translatesAutoresizingMaskIntoConstraints = false
        return yorum
    }()
    
    private let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yükle", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Paylaş"
        view.backgroundColor = .systemBackground
        setupUI()
        setupBindings()
        
        // Gesture Recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        uploadButton.addTarget(self, action: #selector(uploadTiklandi), for: .touchUpInside)
    }
    
    private func setupBindings() {
        // Loading Durumu
        viewModel.onLoading = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.uploadButton.isEnabled = !isLoading
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        // Başarılı Durumu
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(named: "Image")
                self?.yorumTextField.text = ""
                self?.tabBarController?.selectedIndex = 0 
            }
        }
        
        // Hata Durumu
        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.hataGoster(messageInput: errorMessage, TitleInput: "HATA")
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(yorumTextField)
        view.addSubview(uploadButton)
        view.addSubview(activityIndicator)
        
        self.klavyeyiKapatmaOzelligiEkle()
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            yorumTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            yorumTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yorumTextField.widthAnchor.constraint(equalToConstant: 300),
            yorumTextField.heightAnchor.constraint(equalToConstant: 50),
            
            uploadButton.topAnchor.constraint(equalTo: yorumTextField.bottomAnchor, constant: 30),
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            uploadButton.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func gorselSec() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let secilenGorsel = info[.editedImage] as? UIImage {
            imageView.image = secilenGorsel
        } else if let originalGorsel = info[.originalImage] as? UIImage {
            imageView.image = originalGorsel
        }
        self.dismiss(animated: true)
    }
    
    @objc func uploadTiklandi() {
        viewModel.upload(image: imageView.image, comment: yorumTextField.text)
    }
    
    func hataGoster(messageInput: String?, TitleInput: String?) {
        let alert = UIAlertController(title: TitleInput, message: messageInput, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
