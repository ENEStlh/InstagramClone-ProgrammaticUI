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
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemGray5
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
    }()
    
    let likeButton: UIButton = {
        let like = UIButton(type: .system)
        like.setImage(UIImage(systemName: "heart"), for: .normal)
        like.tintColor = .systemRed
        like.translatesAutoresizingMaskIntoConstraints = false
        like.layer.cornerRadius = 16
        like.backgroundColor = .systemGray6
        return like
    }()
    
    let likeLabel: UILabel = {
        let likelabel = UILabel()
        likelabel.font = UIFont.boldSystemFont(ofSize: 15)
        likelabel.text = "0 Beğeni"
        likelabel.textColor = .secondaryLabel
        likelabel.translatesAutoresizingMaskIntoConstraints = false
        return likelabel
    }()
    
    let yorumLabel: UILabel = {
        let yorum = UILabel()
        yorum.font = UIFont.systemFont(ofSize: 14)
        yorum.numberOfLines = 0
        yorum.textColor = .label
        yorum.translatesAutoresizingMaskIntoConstraints = false
        return yorum
    }()
    
    var onLikeTapped: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.05
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 8
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(postImageView)
        contentView.addSubview(emailLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeLabel)
        contentView.addSubview(yorumLabel)
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            postImageView.heightAnchor.constraint(equalToConstant: 220),
            emailLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            likeButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.widthAnchor.constraint(equalToConstant: 36),
            likeButton.heightAnchor.constraint(equalToConstant: 36),
            likeLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 8),
            yorumLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 8),
            yorumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            yorumLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            yorumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
    }
    
    @objc private func likeTapped() {
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
