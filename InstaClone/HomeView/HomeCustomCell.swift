//
//  homeCustomCell.swift
//  InstaClone
//
//  Created by Kingsley Charles on 23/01/2021.
//

import Foundation
import UIKit

class HomeCustomCell: UICollectionViewCell
{
    var post: Posts?
    {
        didSet
        {
            guard let urlString = post?.imageUrl else {return}
            imageView.displayImage(urlString:urlString )
        }
        
    }
    lazy var imageView: LoadImage =
    {
        let iv = LoadImage()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padTop: 0 , padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
