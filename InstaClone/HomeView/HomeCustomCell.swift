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
            guard let aviPicUrl = post?.aviUrl else {return}
            guard let username = post?.username else {return}
            guard let caption = post?.caption else {return}
            DispatchQueue.main.async
            {
                self.profileImage.displayImage(urlString: aviPicUrl)
                self.username.text = username
                self.imageView.displayImage(urlString:urlString )
                self.setUpCaption(username: username, caption: caption)
            }
        }
    }
    lazy var imageView: LoadImage =
    {
        let iv = LoadImage()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var profileImage: LoadImage =
    {
        let iv = LoadImage()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    lazy var username: UILabel =
    {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    lazy var optionsBtn: UIButton =
    {
        let btn = UIButton()
        btn.setTitle("•••", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
        
    }()
    
    //Interactor Butttons
    lazy var likeBtn: UIButton =
    {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    lazy var commentBtn: UIButton =
    {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    lazy var shareBtn: UIButton =
    {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    lazy var bookmarkBtn: UIButton =
    {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    lazy var postsCaption: UITextView =
   {
       let txtView = UITextView()
       return txtView
   }()
   
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        positionItems()
        anchorInteractors()
    }
    
    func setUpCaption(username: String, caption: String)
    {
        let attributedText = NSMutableAttributedString(string: "\(username)  " , attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14) , NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "\(caption)",attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\n\n",attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 4)]))
        attributedText.append(NSAttributedString(string: "2 weeks ago",attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10)]))
        
        postsCaption.attributedText = attributedText
    }
    
    func positionItems()
    {
        addSubview(imageView)
        addSubview(profileImage)
        addSubview(username)
        addSubview(optionsBtn)
        profileImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, padTop: 8, padLeft: 8, padBottom: 0, padRight: 0, width: 40, height: 40)
        optionsBtn.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, padTop: 8, padLeft: 0, padBottom: 0, padRight: 8, width: 44, height: 0)
        imageView.anchor(top: profileImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, padTop: 8 , padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 0)
        username.anchor(top: topAnchor, left: profileImage.rightAnchor, bottom: nil, right: nil, padTop: 16, padLeft: 8, padBottom: 0, padRight: 0, width: 0, height: 0)
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
    }
    
    func anchorInteractors()
    {
        let stackView = UIStackView(arrangedSubviews: [likeBtn,commentBtn,shareBtn])
        addSubview(stackView)
        addSubview(bookmarkBtn)
        addSubview(postsCaption)
        stackView.distribution = .fillEqually
        stackView.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, padTop: 0, padLeft: 8, padBottom: 0, padRight: 0, width: 120, height: 50)
        bookmarkBtn.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 8, width: 45, height: 45)
        postsCaption.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padTop: 0, padLeft: 8, padBottom: 0, padRight: 0, width: 0, height:0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
