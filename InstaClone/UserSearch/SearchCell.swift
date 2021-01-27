//
//  SearchCell.swift
//  InstaClone
//
//  Created by Kingsley Charles on 27/01/2021.
//

import UIKit

class SearchCell: UICollectionViewCell
{
    var user: User?
    {
        didSet
        {
            guard let urlString = user?.profleimageUrl else {return}
            guard let username = user?.username else {return}
            profileImage.displayImage(urlString: urlString)
            profileName.text = username
        }
        
    }
    
    lazy var profileImage: LoadImage =
    {
        let img = LoadImage()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 50/2
        return img
    }()
    
    lazy var profileName: UILabel =
    {
        let lbl = UILabel()
        lbl.text = "Username"
        return lbl
    }()
    
    lazy var seperatorLines: UIView =
    {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return line
    }()
  
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addToFrame()
       
        
    }
    
        required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    func addToFrame()
    {
        addSubview(profileImage)
        addSubview(profileName)
        addSubview(seperatorLines)
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, padTop: 8, padLeft: 8, padBottom: 0, padRight: 0, width: 50, height: 50)
        profileName.anchor(top: topAnchor, left: profileImage.rightAnchor, bottom: nil, right: nil, padTop: 18, padLeft: 8, padBottom: 0, padRight: 0, width: 0, height: 0)
        seperatorLines.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 0.2)
    }
    
}
