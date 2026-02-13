//
//  FeedCell.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell {
    
    // UI Components
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0 // Alt satıra geçebilsin
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit // Resim taşmasın, tamamı görünsün (Instagram genelde 1:1 AspectFill kullanır ama Fit daha güvenlidir)
        image.backgroundColor = .systemGray6
        image.clipsToBounds = true
        return image
    }()
    
    let likeButton: UIButton = {
        let like = UIButton(type: .system)
        // "Like" yazısını kaldırdık, sadece ikon olsun
        like.setImage(UIImage(systemName: "heart"), for: .normal)
        like.tintColor = .black
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    
    let likeLabel: UILabel = {
        let likelabel = UILabel()
        likelabel.font = UIFont.boldSystemFont(ofSize: 15)
        likelabel.text = "0 Beğeni" // Sadece sayı değil, yanında metin de olabilir
        likelabel.translatesAutoresizingMaskIntoConstraints = false
        return likelabel
    }()
    
    let yorumLabel: UILabel = {
        let yorum = UILabel()
        yorum.font = UIFont.systemFont(ofSize: 14) // Yorumlar genelde bold olmaz
        yorum.numberOfLines = 0 // Uzun yorumlar tamamı görünsün
        yorum.translatesAutoresizingMaskIntoConstraints = false
        return yorum
    }()
    
    // Button Action için Closure
    var onLikeTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(emailLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeLabel)
        contentView.addSubview(yorumLabel) // Sırayla ekledik
        
        NSLayoutConstraint.activate([
            // 1. Email (En Üst)
            emailLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            // 2. Görsel (Email'in altı)
            postImageView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), // Kenarlara yapışık olsun
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 300), // Sabit yükseklik (veya aspect ratio verilebilir)
            
            // 3. Like Butonu (Görselin altı)
            likeButton.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            likeButton.widthAnchor.constraint(equalToConstant: 40), // Sadece ikon olduğu için küçülttük
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            
            // 4. Like Sayısı (Butonun yanı)
            likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5),
            
            // 5. Yorum (Butonun altı)
            yorumLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 5),
            yorumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            yorumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            yorumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func likeButtonAction() {
        onLikeTapped?()
    }
    
    func configure(with post: Post, isLiked: Bool) {
        emailLabel.text = post.postedBy
        yorumLabel.text = post.postComment
        likeLabel.text = "\(post.likes) Beğeni"
        postImageView.sd_setImage(with: URL(string: post.imageUrl))
        
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
            likeButton.isEnabled = false
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .black
            likeButton.isEnabled = true
        }
    }
}
