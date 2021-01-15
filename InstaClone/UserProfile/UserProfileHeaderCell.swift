//
//  UserProfileViewCell.swift
//  InstaClone
//
//  Created by Kingsley Charles on 15/01/2021.
//

import UIKit

class UserProfileHeaderCell: UICollectionViewCell {
    
    let profileImageVew : UIImageView =
    {
        let iv = UIImageView()
        iv.layer.cornerRadius = 40
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(profileImageVew)
        profileImageVew.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, padTop: 8, padLeft: 8, padBottom: 0, padRight: 0, width: 80, height: 80)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
