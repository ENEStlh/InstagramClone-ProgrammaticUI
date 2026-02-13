//
//  Posts.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 13.02.2026.
//

import Foundation

struct Post {
    let documentId: String
    let postedBy: String
    let imageUrl: String
    let postComment: String
    var likes: Int
    let likedBy: [String]
}
