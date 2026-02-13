//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    // UI elementleri
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "Image")
        imageview.contentMode = .scaleAspectFit
        imageview.tintColor = .darkGray
        imageview.isUserInteractionEnabled = true  // tıklanılabilir
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
    
    private let uploadButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yükle", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Paylaş"
        setupUI()
        
        // resme tıklanınca görsel secilsin
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        uploadButton.addTarget(self, action: #selector(uploadTiklandi), for: .touchUpInside)
        
        
    }
    
    func setupUI(){
        view.addSubview(imageView)
        view.addSubview(yorumTextField)
        view.addSubview(uploadButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 320),
            imageView.heightAnchor.constraint(equalToConstant: 275),
            
            yorumTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            yorumTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yorumTextField.widthAnchor.constraint(equalToConstant: 225),
            yorumTextField.heightAnchor.constraint(equalToConstant: 50),
            
            uploadButton.topAnchor.constraint(equalTo: yorumTextField.bottomAnchor, constant: 30),
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            uploadButton.heightAnchor.constraint(equalToConstant: 50)
            
            
            
            
            
        ])
        
        
        
    }
    // Galeri İşlemi
    @objc func gorselSec(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary // kamera için .camera yaz
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    // resim secince burası calısır
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let secilenGorsel = info[.editedImage] as? UIImage {
            imageView.image = secilenGorsel
        }
        else if let originalGorsel = info[.originalImage] as? UIImage{
            imageView.image = originalGorsel

        }
        self.dismiss(animated: true,completion: nil)
          
          
    }
    // Firebase Upload işlemi
    @objc func uploadTiklandi(){
        
        // Güvenlik Kontrolü Resim VAr mı?
        // Varsayılan resim(sistem ikonu ) ise işlem yapma
        guard let image = imageView.image , image != UIImage(named:  "Image") else{
            self.hataGoster(messageInput: "Bir Fotoğraf Seciniz", TitleInput: "HATA")
            return
        }
        // Butonu kilitle
        uploadButton.isEnabled = false
        // 2. Storage referansı olusturma
        let Storage = Storage.storage()
        let StorageReference = Storage.reference()
        
        let mediaFolder = StorageReference.child("media") // klasörün adı
        
        // Her resmin farklı adı olmalı UUID kullanıyorum
        
        let uuid = UUID().uuidString
        let imageReference = mediaFolder.child("\(uuid).jpg")
        
        // 3.resmi VEriye cevirme
        
        if let data = image.jpegData(compressionQuality: 0.5) {// %50 sıkıstırma
            // 4.Storageye Yükleme
            imageReference.putData(data, metadata: nil){(metadata,error) in
                if error != nil {
                    self.hataGoster(messageInput: error?.localizedDescription ?? "hata", TitleInput: "HATA")
                    self.uploadButton.isEnabled = true
                    return
                }
                // 5. url Yükleme
                imageReference.downloadURL(){(url,error)  in
                    if let error = error {
                        self.hataGoster(messageInput: error.localizedDescription, TitleInput: "HATA")
                        return
                    }
                    guard let imageUrl = url?.absoluteString else {return}
                    
                    //6. FireStora kaydet
                    self.firestoreKaydet(imageUrl:imageUrl)
                }
            }
            
        }
        
        
    }
    
    func firestoreKaydet(imageUrl:String){
        let firestore = Firestore.firestore()
        
        // Veri Dictionary
        let post = [
            "imageUrl": imageUrl,
            "PostedBy": Auth.auth().currentUser?.email ?? "BİLİNMEYEN",
            "PostComment": yorumTextField.text ?? "",
            "date": FieldValue.serverTimestamp(),
            "likes":0,
            "likedBy": [String]() // BURASI YENİ EKLENDİ (Boş Liste)
        ] as [String:Any]
        
        // VEri EKLE
        firestore.collection("Posts").addDocument(data: post){
            error in
            if error != nil {
                self.hataGoster(messageInput: error?.localizedDescription ?? "HATA", TitleInput: "HATA")
                self.uploadButton.isEnabled = true
            }else{
                // BAŞARILI TEMİZLİK ZAMANI
                self.uploadButton.isEnabled = true
                self.imageView.image = UIImage(named: "Image")// resmi sıfırla
                self.yorumTextField.text = "" //yazıyı sıfırla
                
                // ANA SAYFAYA FEEDE ISINLAN TAB BAR index == 0
                self.tabBarController?.selectedIndex = 0
            }
        }
        
    }
    
    func hataGoster(messageInput:String?,TitleInput:String?){
        let alert = UIAlertController(title: TitleInput, message: messageInput, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(OkAction)
        present(alert, animated: true)
    }
    

 

}
