//
//  UploadViewModel.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 13.02.2026.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewModel {
    var onLoading: ((Bool) -> Void)?
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func upload(image: UIImage?, comment: String?) {
        guard let image = image, image != UIImage(named: "Image") else {
            onError?("Bir Fotoğraf Seçiniz"); return
        }
        onLoading?(true)
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = Storage.storage().reference().child("media/\(UUID().uuidString).jpg")
        
        ref.putData(data, metadata: nil) { [weak self] _, error in
            if let error = error { self?.handleError(error); return }
            
            ref.downloadURL { url, error in
                if let error = error { self?.handleError(error); return }
                self?.saveToFirestore(url: url?.absoluteString ?? "", comment: comment ?? "")
            }
        }
    }
    
    private func saveToFirestore(url: String, comment: String) {
        let post = ["imageUrl": url, "PostedBy": Auth.auth().currentUser?.email ?? "", "PostComment": comment, "date": FieldValue.serverTimestamp(), "likes": 0, "likedBy": []] as [String : Any]
        
        Firestore.firestore().collection("Posts").addDocument(data: post) { [weak self] error in
            self?.onLoading?(false)
            if let error = error { self?.onError?(error.localizedDescription) }
            else { self?.onSuccess?() }
        }
    }
    
    private func handleError(_ error: Error) {
        onLoading?(false)
        onError?(error.localizedDescription)
    }
}
