//
//  SharePhotoViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 21/01/2021.
//

import UIKit

class SharePhotoViewController: UIViewController {

    var imageSetter:UIImage?
    {
        didSet {
            
            shareImage.image = self.imageSetter

        }
        
    }
    
    let shareImage: UIImageView =
    {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
        
    }()
    
    let caption : UITextField =
    {
        let txt = UITextField()
        txt.font = UIFont.systemFont(ofSize: 14)
        return txt
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupBarButton()
        setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupBarButton()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SharePhoto", style: .plain, target: self, action: #selector(sharePhoto))
        
    }
    
    @objc func sharePhoto ()
    {
        print("Photo Shared")
        
    }
    
    @objc func cancelPressed ()
    {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupView()
    {
        let shareview = UIView()
        shareview.backgroundColor = .white
        view.addSubview(shareview)
        view.addSubview(shareImage)
        view.addSubview(caption)
        shareview.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 100)
        
        shareImage.anchor(top: shareview.topAnchor, left: shareview.leftAnchor, bottom: shareview.bottomAnchor, right: nil, padTop: 8, padLeft: 8, padBottom: 8, padRight: 0, width: 84, height: 0)
        
        caption.anchor(top: shareview.topAnchor, left: shareImage.rightAnchor, bottom: nil, right: shareview.rightAnchor, padTop: 0, padLeft: 8, padBottom: 0, padRight: 8, width: 0, height: 0)
        
        
        
    }
    
    

    
    

}
