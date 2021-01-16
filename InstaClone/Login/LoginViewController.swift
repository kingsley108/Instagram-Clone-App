//
//  LoginViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 16/01/2021.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var isFilledCorrect = false
    let headerView: UIView =
    {
        let vw = UIView()
        vw.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        //Adding imageview for Logo
        var logoImageView = UIImageView()
        vw.addSubview(logoImageView)
        logoImageView.image = #imageLiteral(resourceName: "Instagram_logo_white")
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 200, height: 50)
        logoImageView.centerXAnchor.constraint(equalTo: vw.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: vw.centerYAnchor).isActive = true
        logoImageView.contentMode = .scaleAspectFill
        return vw
    }()
        
    let promptSignUp: UIButton =
    {
        let btn = UIButton()
        
        let attributedText = NSMutableAttributedString(string: "Don't have an account?" , attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14) , NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        attributedText.append(NSAttributedString(string: " Sign up",attributes: [NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 17, green: 154, blue: 237), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]))
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(navigateSignUp), for: .touchUpInside)
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
    
    let loginButton : UIButton =
        {
            let btn = UIButton()
            btn.setTitle("Log In", for: .normal)
            btn.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            btn.titleLabel?.textColor = .white
            btn.layer.cornerRadius = 5
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            btn.isEnabled = false
            btn.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
            
            return btn
            
            
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(promptSignUp)
        promptSignUp.anchor(top:nil, left:view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padTop: 0, padLeft: 0, padBottom: 25, padRight: 0, width: 0, height: 50)
        view.addSubview(headerView)
        headerView.anchor(top:view.topAnchor, left: view.leftAnchor, bottom:nil, right: view.rightAnchor, padTop: 0, padLeft: 0, padBottom: 0, padRight: 0, width: 0, height: 150)
        
        setUpInputs()
        
        //Set keyboard delegate methods
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    
    @objc func isTextFull()
    {
        isFilledCorrect = emailTextfield.text!.count > 0 && passwordTextfield.text!.count > 0
        
        if isFilledCorrect
        {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
            
        }
        else
        {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            
        }
    }
    
    fileprivate func setUpInputs()
    {
        let layoutStack = UIStackView(arrangedSubviews: [emailTextfield,passwordTextfield,loginButton])
        view.addSubview(layoutStack)
        layoutStack.distribution = .fillEqually
        layoutStack.spacing = 15
        layoutStack.axis = .vertical
        
        //Setting up positioning
        layoutStack.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padTop: 80, padLeft: 40, padBottom: 0, padRight: 40 , width: 0, height: 150)
        
        
    }
    
    
    @objc func navigateSignUp ()
    {
        let signUpVc = RegisterViewController()
        navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    //MARK: Logging in functionality
    @objc func loginPressed ()
    {
       
        guard let email = emailTextfield.text , let password = passwordTextfield.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            print("Logged in")
            guard let rootVc = UIApplication.shared.windows.first!.rootViewController as? MainTabBarController else {return}
            rootVc.setUpVc()
            self.dismiss(animated: true, completion: nil)
            
        } //Signing in function from firebase
        
    }
}
