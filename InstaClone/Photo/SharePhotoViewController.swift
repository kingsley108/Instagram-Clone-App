//
//  SharePhotoViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 21/01/2021.
//

import UIKit
import Firebase

class SharePhotoViewController: UIViewController {
    
    var imageSetter:UIImage? {didSet {shareImage.image = self.imageSetter}}
    
    let shareImage: UIImageView =
        {
            let iv = UIImageView()
            iv.clipsToBounds = true
            iv.contentMode = .scaleAspectFill
            return iv
            
        }()
    
    let caption : UITextView =
        {
            let txt = UITextView()
            txt.font = UIFont.systemFont(ofSize: 14)
            txt.textAlignment = .left
            return txt
        }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupBarButton()
        setupView()
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    func setupBarButton()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(sharePhoto))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    //Method to share images
    @objc func sharePhoto ()
    {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        guard let imageData = shareImage.image?.jpegData(compressionQuality: 0.5) else {return}
        let randomString = UUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(randomString)
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            
            if let error = error {
                print("Failed to upload post into storage" , error)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            storageRef.downloadURL { (url, err) in
                if err != nil
                {
                    print("Couldn't download the data into url", err as Any)
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    return
                }
                guard let downloadUrl = url?.absoluteString else {return}
                self.savePostsToDatabase(imageUrl: downloadUrl)
            }
        }
    }
    
    @objc func cancelPressed ()
    {self.dismiss(animated: true, completion: nil)}
    
    func setupView()
    {
        let shareview = UIView()
        shareview.backgroundColor = .white
        view.addSubview(shareview)
        view.addSubview(shareImage)
        view.addSubview(caption)
        caption.backgroundColor = .yellow
        shareview.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 100)
        
        shareImage.anchor(top: shareview.topAnchor, left: shareview.leftAnchor, bottom: shareview.bottomAnchor, right: nil, padTop: 8, padLeft: 8, padBottom: 8, padRight: 0, width: 84, height: 0)
        
        caption.anchor(top: shareview.topAnchor, left: shareImage.rightAnchor, bottom: shareview.bottomAnchor, right: shareview.rightAnchor, padTop: 12, padLeft: 12, padBottom: 8, padRight: 12, width: 0, height: 0)
    }
    
    func savePostsToDatabase(imageUrl: String)
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let width = shareImage.image?.size.width , let height = shareImage.image?.size.width else {return}
        let ref = Database.database().reference()
        guard let caption = caption.text else {return}
        let creationDate = Date().timeIntervalSince1970
        let values : [String: Any] = ["imageUrl": imageUrl,"Caption": caption,"imageWidth": width, "imageHeight": height, "Creation Date": creationDate]
        
        let path = ref.child("posts").child(uid).childByAutoId()
        path.updateChildValues(values) { (err, reference) in
            if let err = err
            {
                print("Failed to upload posts to database", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            print("succesfully put in database")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
