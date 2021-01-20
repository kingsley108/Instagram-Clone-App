//
//  PhotoCollectionViewCell.swift
//  InstaClone
//
//  Created by Kingsley Charles on 20/01/2021.
//

import UIKit

class PhotoCell: UICollectionViewCell
{
    var representedAssetIdentifier: String? = nil
    let photoView:UIImageView =
    {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoView)
        photoView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
