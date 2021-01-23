//
//  UserPostsCell.swift
//  InstaClone
//
//  Created by Kingsley Charles on 22/01/2021.
//

import UIKit

class UserPostsCell: UICollectionViewCell
{
    var post: Posts?
    {
        didSet
        {
            guard let urlString = post?.imageUrl else {return}
            newPostImage.displayImage(urlString: urlString)
        } 
    }
    
    let newPostImage: loadImage =
    {
        let iv = loadImage()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(newPostImage)
        newPostImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
