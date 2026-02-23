//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let viewModel = UploadViewModel()
    
    // Modern UI Elements
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "Image")
        imageview.contentMode = .scaleAspectFill
        imageview.tintColor = .systemPurple
        imageview.layer.cornerRadius = 20
        imageview.clipsToBounds = true
        imageview.layer.borderWidth = 2
        imageview.layer.borderColor = UIColor.systemPurple.withAlphaComponent(0.2).cgColor
        imageview.isUserInteractionEnabled = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private let yorumTextField: UITextField = {
        let yorum = UITextField()
        yorum.placeholder = "Yorumunuzu Yazınız"
        yorum.borderStyle = .none
        yorum.backgroundColor = UIColor.systemGray6
        yorum.layer.cornerRadius = 12
        
        yorum.translatesAutoresizingMaskIntoConstraints = false
        yorum.font = UIFont.systemFont(ofSize: 16)
        return yorum
    }()
    
    private let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yükle", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.shadowColor = UIColor.systemPurple.cgColor
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
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
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
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
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPurple.withAlphaComponent(0.15).cgColor, UIColor.systemBlue.withAlphaComponent(0.15).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let stack = UIStackView(arrangedSubviews: [imageView, yorumTextField, uploadButton, activityIndicator])
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 220),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            yorumTextField.heightAnchor.constraint(equalToConstant: 48),
            uploadButton.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40)
        ])
        uploadButton.addTarget(self, action: #selector(uploadTiklandi), for: .touchUpInside)
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
