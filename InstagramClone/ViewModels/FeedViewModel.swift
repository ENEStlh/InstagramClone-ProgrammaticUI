//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 13.02.2026.
//

import FirebaseFirestore
import FirebaseAuth

class FeedViewModel {
    var onDataUpdated: (() -> Void)?
    private(set) var posts = [Post]()
    
    func fetchPosts() {
        Firestore.firestore().collection("Posts")
            .order(by: "date", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error { print(error.localizedDescription); return }
                
                self?.posts = snapshot?.documents.compactMap { doc -> Post? in
                    let data = doc.data()
                    return Post(
                        documentId: doc.documentID,
                        postedBy: data["PostedBy"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        postComment: data["PostComment"] as? String ?? "",
                        likes: data["likes"] as? Int ?? 0,
                        likedBy: data["likedBy"] as? [String] ?? []
                    )
                } ?? []
                self?.onDataUpdated?()
            }
    }
    
    func likePost(at index: Int) {
        guard let email = Auth.auth().currentUser?.email else { return }
        let post = posts[index]
        Firestore.firestore().collection("Posts").document(post.documentId).updateData([
            "likes": FieldValue.increment(Int64(1)),
            "likedBy": FieldValue.arrayUnion([email])
        ])
    }
}
