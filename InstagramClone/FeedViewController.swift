//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import FirebaseFirestore
import SDWebImage
import FirebaseAuth

class FeedViewController: UIViewController,UITableViewDelegate , UITableViewDataSource {
    
    private let tableView = UITableView()
    
    // DATA Modelleri
    var likedByArray = [[String]]() // Dizi içinde dizi (Her postun beğenenleri listesi)
    var emailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ANASAYFA"
        view.backgroundColor = .systemBackground
        setupTableView()
        getDatafromFirestore()
        
    }
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedCell.self, forCellReuseIdentifier: "Cell")
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                                    ])
    }
    
    func getDatafromFirestore() {
        
        let firestore = Firestore.firestore()
        
        firestore.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                print(error?.localizedDescription ??  "HATA")
            }
            else{
                if let snapshot = snapshot, !snapshot.isEmpty {
                    self.documentIdArray.removeAll()
                    self.emailArray.removeAll()
                    self.likeArray.removeAll()
                    self.userImageArray.removeAll()
                    self.userCommentArray.removeAll()
                    self.likedByArray.removeAll()
                    
                    for document in snapshot.documents{
                        self.documentIdArray.append(document.documentID)
                        
                        if let PostedBy = document.get("PostedBy") as? String { self.emailArray.append(PostedBy)}
                        if let image = document.get("imageUrl") as? String { self.userImageArray.append(image)}
                        if let comment = document.get("PostComment") as? String { self.userCommentArray.append(comment)}
                        if let likes = document.get("likes") as? Int { self.likeArray.append(likes)}
                        // YENİ: Beğenenler listesini çek
                                            if let likers = document.get("likedBy") as? [String] {
                                                self.likedByArray.append(likers)
                                            } else {
                                                // Eski kayıtlarda bu alan yoksa boş dizi ekle ki çökmesin
                                                self.likedByArray.append([])
                                            }
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.emailLalbe.text = emailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.yorumLabel.text = userCommentArray[indexPath.row]
        cell.labelID.text = documentIdArray[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: userImageArray[indexPath.row]))
        // BEĞENİ KONTROLÜ
        let currentUserEmail = Auth.auth().currentUser?.email
        let likers = likedByArray[indexPath.row]
        
        if likers.contains(currentUserEmail ?? "") {
            // Zaten beğenmiş: İçi dolu kalp ve tıklanamaz
            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.likeButton.tintColor = .red
            cell.likeButton.isEnabled = false
        } else {
            // Henüz beğenmemiş: Boş kalp ve tıklanabilir
            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.likeButton.tintColor = .systemBlue // veya siyah, tasarımına göre
            cell.likeButton.isEnabled = true
        }
            return cell
        }
    
    
    
}

