//
//  ViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 05/01/2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController
{
    public var isFilledCorrect : Bool = false
    
    let plusButton : UIButton =
    {
        var btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        return btn

    }()
    
    let emailTextfield : UITextField =
    {
        var txt = UITextField()
        txt.placeholder = "Email"
        txt.borderStyle = .roundedRect
        txt.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txt.font = UIFont.systemFont(ofSize: 14)
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
        
        //Constraints of Button
        plusButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, padTop: 60, padLeft: 0, padBottom: 0, padRight: 0, width: 140, height: 140)
        plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //set up position of textfield
        setUpStackview()
        
        
        
    }
    
    
    fileprivate func setUpStackview()
    {
        let layoutStack = UIStackView(arrangedSubviews: [emailTextfield,usernameTextfield,passwordTextfield,signupButton])
        
        view.addSubview(layoutStack)
        layoutStack.distribution = .fillEqually
        layoutStack.spacing = 15
        layoutStack.axis = .vertical
        
        //Setting up positioning
        layoutStack.anchor(top: plusButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padTop: 30, padLeft: 40, padBottom: 0, padRight: -40 , width: 0, height: 0)
        
        
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
        
        
        
        Auth.auth().createUser(withEmail: email, password: password)
        { authResult, error in
            
            if let error = error
            {
                print(error)
                return
                
            }
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            let usernameVal = ["username" : username]
            let userDict = [ uid: usernameVal]
            
            Database.database().reference().child("users").updateChildValues(userDict, withCompletionBlock: { (err, ref) in
                
                if let err = err {
                    print("Failed to save user info into db:", err)
                    return
                }
                
                print("Successfully saved user info to db")
                
            })
   
            
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

}

