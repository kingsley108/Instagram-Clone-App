//
//  ViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 05/01/2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class RegisterViewController: UIViewController
{
    public var isFilledCorrect : Bool = false
    
    let plusButton : UIButton =
        {
            var btn = UIButton()
            btn.contentHorizontalAlignment = .fill
            btn.contentVerticalAlignment = .fill
            btn.imageView?.contentMode = .scaleAspectFill
            btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
            btn.addTarget(self, action: #selector(addProfilePic), for: .touchUpInside)
            return btn
            
        }()
    
    let emailTextfield : UITextField =
        {
            var txt = UITextField()
            txt.placeholder = "Email"
            txt.borderStyle = .roundedRect
            txt.backgroundColor = UIColor(white: 0, alpha: 0.03)
            txt.font = UIFont.systemFont(ofSize: 14)
            txt.text = "Kingsley108@yahoo.com"
            txt.addTarget(self, action: #selector(isTextFull), for: .editingChanged)
            return txt
            
            
        }()
    
    let usernameTextfield : UITextField =
        {
            var txt = UITextField()
            txt.placeholder = "Username"
            txt.borderStyle = .roundedRect
            txt.backgroundColor = UIColor(white: 0, alpha: 0.03)
            txt.font = UIFont.systemFont(ofSize: 14)
            txt.addTarget(self, action: #selector(isTextFull), for: .editingChanged)
            txt.text = "Kingsley"
            return txt
        }()
    
    let passwordTextfield : UITextField =
        {
            var txt = UITextField()
            txt.placeholder = "Password"
            txt.borderStyle = .roundedRect
            txt.backgroundColor = UIColor(white: 0, alpha: 0.03)
            txt.font = UIFont.systemFont(ofSize: 14)
            txt.isSecureTextEntry = true
            txt.addTarget(self, action: #selector(isTextFull), for: .editingChanged)
            return txt
        }()
    
    
    let promptSignIn: UIButton =
        {
            let btn = UIButton()
            
            let attributedText = NSMutableAttributedString(string: "Have an account?" , attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14) , NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            
            attributedText.append(NSAttributedString(string: " Sign In",attributes: [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 17, green: 154, blue: 237), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]))
            btn.setAttributedTitle(attributedText, for: .normal)
            btn.setTitleColor(.blue, for: .normal)
            btn.addTarget(self, action: #selector(naviagateSignIn), for: .touchUpInside)
            return btn
        }()
    
    let signupButton : UIButton =
        {
            let btn = UIButton()
            btn.setTitle("Sign up", for: .normal)
            btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            btn.titleLabel?.textColor = .white
            btn.layer.cornerRadius = 5
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            btn.isEnabled = false
            btn.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
            
            return btn
            
            
        }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(plusButton)
        view.addSubview(emailTextfield)
        view.addSubview(usernameTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(signupButton)
        view.backgroundColor = .white
        //Constraints of Button
        plusButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, padTop: 60, padLeft: 0, padBottom: 0, padRight: 0, width: 140, height: 140)
        plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //Set up position of textfield
        setUpStackview()
        
        //Setup position of sign in prompt to users that have an account
        
        view.addSubview(promptSignIn)
        promptSignIn.anchor(top:nil, left:view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padTop: 0, padLeft: 0, padBottom: 25, padRight: 0, width: 0, height: 50)
    }
    
    
    fileprivate func setUpStackview()
    {
        let layoutStack = UIStackView(arrangedSubviews: [emailTextfield,usernameTextfield,passwordTextfield,signupButton])
        
        view.addSubview(layoutStack)
        layoutStack.distribution = .fillEqually
        layoutStack.spacing = 15
        layoutStack.axis = .vertical
        
        //Setting up positioning
        layoutStack.anchor(top: plusButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padTop: 30, padLeft: 40, padBottom: 0, padRight: 40 , width: 0, height: 0)
        
        
    }
    
    //Method to handle navigation to login page
    @objc func naviagateSignIn ()
    {
        let loginVc = LoginViewController()
        navigationController?.pushViewController(loginVc, animated: true)
        
    }
    
    
    //MARK: Registering Users
    
    @objc func signUpPressed ()
    {
        //Check property isnt empty
        guard let email = emailTextfield.text, email.count > 0 else
        {
            print("error with email text")
            return
        }
        
        guard let password = passwordTextfield.text, password.count > 0 else
        {
            print("error with password textfield")
            return
        }
        
        guard let username = usernameTextfield.text, username.count > 0 else
        {
            print("error with username textfield")
            return
        }
        
        guard let photo = self.plusButton.imageView?.image else {return}
        
        guard let uploadData = photo.jpegData(compressionQuality: 0.3) else {return}
        
        
        Auth.auth().createUser(withEmail: email, password: password)
        { authResult, error in
            
            if let error = error
            {
                print(error)
                return
            }
            print("User Creation done")
            
            let uuid = UUID().uuidString
            
            let storageRef = Storage.storage().reference().child("images").child(uuid)
            
            storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
                
                if let err = err
                {
                    print("error",err)
                    return
                    
                }
                print("photos stored in storage.")
                
                storageRef.downloadURL { (url, err) in
                    
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    guard let imageUrl = url?.absoluteString else {return}
                    
                    let usernameVal = ["username" : username , "profileURL" : imageUrl]
                    let userDict = [ uid: usernameVal]
                    
                    Database.database().reference().child("users").updateChildValues(userDict, withCompletionBlock: { (err, ref) in
                        
                        if let err = err {
                            print("Failed to save user info into db:", err)
                            return
                        }
                        print("Successfully saved user info to db")
                    })
                    
                } //Download image URL
                
            }
            
        }
    }
    
    @objc func isTextFull()
    {
        isFilledCorrect = emailTextfield.text!.count > 0 && passwordTextfield.text!.count > 0 && passwordTextfield.text!.count > 0
        
        if isFilledCorrect
        {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
            
        }
        else
        {
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            
        }
        
        
    }
    
    @objc func addProfilePic ()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}

//MARK: - Delegate methods for imagePicker

extension RegisterViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            plusButton.setImage(tempImage, for: .normal)
            dismiss(animated: true, completion: nil)
            
        }
        else if let tempImage = info[.editedImage] as? UIImage
        {
            plusButton.setImage(tempImage, for: .normal)
            dismiss(animated: true, completion: nil)
            
        }
        
        
        plusButton.layer.cornerRadius = plusButton.frame.width / 2
        plusButton.layer.masksToBounds = true
        plusButton.layer.borderWidth = 3
        plusButton.layer.borderColor = UIColor.black.cgColor
        
        return
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

