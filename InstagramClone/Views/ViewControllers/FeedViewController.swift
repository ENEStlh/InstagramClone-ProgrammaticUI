//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 31.12.2025.
//

import UIKit
import FirebaseAuth

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let viewModel = FeedViewModel() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ANASAYFA"
        view.backgroundColor = .systemBackground
        setupTableView()
        setupBindings()
        
        // Verileri çekmeye başla
        viewModel.fetchPosts()
    }
    
    private func setupBindings() {
        // ViewModel'den "veri güncellendi" sinyali gelince tabloyu yenile
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedCell.self, forCellReuseIdentifier: "Cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        let post = viewModel.posts[indexPath.row]
        let currentUserEmail = Auth.auth().currentUser?.email ?? ""
        
        // Modelden gelen veri ile hücreyi doldur
        let isLiked = post.likedBy.contains(currentUserEmail)
        cell.configure(with: post, isLiked: isLiked)
        
        // Hücredeki butona basılınca ViewModel'e haber ver
        cell.onLikeTapped = { [weak self] in
            self?.viewModel.likePost(at: indexPath.row)
        }
        
        return cell
    }
}
