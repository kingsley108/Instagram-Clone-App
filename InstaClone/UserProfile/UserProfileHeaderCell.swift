//
//  UserProfileViewCell.swift
//  InstaClone
//
//  Created by Kingsley Charles on 15/01/2021.
//

import UIKit

class UserProfileHeaderCell: UICollectionViewCell {
    
    var user : User?
    {
        didSet
        {
            guard let profileUser = user?.username else {return}
            username.text = profileUser
            
            //Get the Image from this using url session
            guard let urlString = user?.profleimageUrl else {return}
            profileImageView.displayImage(urlString: urlString)
            
        }
    }
    
    
    let profileImageView: loadImage  =
        {
            let iv = loadImage()
            iv.layer.cornerRadius = 40
            iv.clipsToBounds = true
            iv.contentMode = .scaleAspectFill
            return iv
        }()
    
    let gridButton: UIButton =
        {
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
            return btn
        }()
    
    let ribbonButton: UIButton =
        {
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "list"), for: .normal)
            return btn
        }()
    
    let savedButton: UIButton =
        {
            let btn = UIButton()
            btn.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
            btn.tintColor = UIColor(white: 0, alpha: 0.3)
            return btn
        }()
    
    let username: UILabel =
        {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.boldSystemFont(ofSize:14)
            return lbl
        }()
    
    let postsLabel : UILabel =
        {
            let lbl = UILabel()
            let attributedText = NSMutableAttributedString(string: "11\n" , attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "posts",attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
            
            lbl.textColor = .black
            
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            
            
            lbl.attributedText = attributedText
            return lbl
        }()
    
    let editProfile: UIButton =
        {
            let btn = UIButton()
            btn.setTitle("Edit Profile", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            return btn
            
        }()
    
    let followersLabel : UILabel =
        {
            let lbl = UILabel()
            let attributedText = NSMutableAttributedString(string: "11\n" , attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "posts",attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
            
            lbl.textColor = .black
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            
            
            lbl.attributedText = attributedText
            return lbl
        }()
    
    let followingLabel : UILabel =
        {
            let lbl = UILabel()
            let attributedText = NSMutableAttributedString(string: "11\n" , attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "posts",attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
            
            lbl.textColor = .black
            lbl.textAlignment = .center
            lbl.numberOfLines = 0
            
            lbl.attributedText = attributedText
            return lbl
        }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, padTop: 12, padLeft: 8, padBottom: 0, padRight: 0, width: 80, height: 80)
        
        setupButtons()
        arrangeLabels()
        
        //Setup for edit profie button
        addSubview(editProfile)
        editProfile.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, padTop: 2, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 34)
        
    }
    
    func arrangeLabels()
    {
        let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel, followingLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: rightAnchor, padTop: 12, padLeft: 12, padBottom: 0, padRight: 12, width: 0, height: 50)
        
    }
    
    func setupButtons()
    {
        let stackView = UIStackView(arrangedSubviews: [ribbonButton,gridButton,savedButton])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: nil, left:leftAnchor, bottom: bottomAnchor, right: rightAnchor, padTop: 0 , padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 50)
        
        let bottomSeperator = UIView()
        bottomSeperator.backgroundColor = UIColor.lightGray
        let topSeperator = UIView()
        topSeperator.backgroundColor = UIColor.lightGray
        addSubview(topSeperator)
        addSubview(bottomSeperator)
        topSeperator.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 0.5)
        bottomSeperator.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom:nil, right: rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 1)
        
        setupUsername()
    }
    
    func setupUsername()
    {
        addSubview(username)
        username.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: gridButton.topAnchor, right: nil, padTop:0, padLeft: 12, padBottom: 12, padRight: 0, width: 0, height: 0)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
