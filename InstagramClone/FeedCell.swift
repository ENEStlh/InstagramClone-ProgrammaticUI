//
//  FeedCell.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class FeedCell: UITableViewCell {
    
    // UI Components
    
    let emailLalbe:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImageView:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemGray6
        return image
    }()
    
    let likeButton:UIButton = {
        let like = UIButton()
        like.setTitle("Like", for: .normal )
        like.setTitleColor(.black, for: .normal)
        like.translatesAutoresizingMaskIntoConstraints = false
        like.setImage(UIImage(systemName: "heart"), for: .normal)
        return like
    }()
    
    let yorumLabel:UILabel = {
        let yorum = UILabel()
        yorum.font = UIFont.boldSystemFont(ofSize: 15)
        yorum.translatesAutoresizingMaskIntoConstraints = false
        return yorum
    }()
    
    let likeLabel:UILabel = {
        let likelabel = UILabel()
        likelabel.font = UIFont.boldSystemFont(ofSize: 15)
        likelabel.text = "0"
        likelabel.translatesAutoresizingMaskIntoConstraints = false
        return likelabel
    }()
    
    // firestore için ID yi gizlice tutacagız
    let labelID: UILabel = {
        let lbl = UILabel()
        lbl.isHidden = true
        return lbl
    }()

    // MARK: - Init (Storyboard Olmadığı İçin Burası Çalışır)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        
        //  like button tıklama özelliği
        
        likeButton.addTarget(self, action: #selector(likebuttonbasildi), for: .touchUpInside)
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    // LAyout Setup
    
    private func setupUI() {
        contentView.addSubview(emailLalbe)
        contentView.addSubview(postImageView)
        contentView.addSubview(yorumLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeLabel)
        contentView.addSubview(labelID)
        
        NSLayoutConstraint.activate([
            // email en üst sol
            emailLalbe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            emailLalbe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            emailLalbe.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            // görsel
            postImageView.topAnchor.constraint(equalTo: emailLalbe.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            postImageView.heightAnchor.constraint(equalToConstant: 300),
            
            // like button
            
            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            likeButton.widthAnchor.constraint(equalToConstant: 80),
            
            // like label
            
            likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 10),
            
            // yorum label
            
            yorumLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 10),
            yorumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            yorumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            yorumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
            
        ])
    }
    
    @objc func likebuttonbasildi() {
        
        guard let currentUserEmail = Auth.auth().currentUser?.email else { return }
        
        let firestore = Firestore.firestore()
        
        // 1. Sayıyı 1 arttır
        // 2. Beğenenler listesine (likedBy) kendini ekle (arrayUnion)
        let likeStore = [
            "likes": FieldValue.increment(Int64(1)),
            "likedBy": FieldValue.arrayUnion([currentUserEmail])
        ] as [String : Any]
        
        if let docID = labelID.text {
            firestore.collection("Posts").document(docID).updateData(likeStore) { error in
                if error == nil {
                    // Başarılı olursa anlık olarak butonu kilitle (Görsel hemen değişsin)
                    self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    self.likeButton.tintColor = .red
                    self.likeButton.isEnabled = false
                }
            }
        }
    }
     
    

}
