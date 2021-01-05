//
//  ViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 05/01/2021.
//

import UIKit

class ViewController: UIViewController
{
    let plusButton : UIButton =
    {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        return btn

    }()
    
    let emailTextfield : UITextField =
    {
        var txt = UITextField()
        txt.placeholder = "Email"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txt.font = UIFont.systemFont(ofSize: 14)
        return txt
        
        
    }()
    
    let usernameTextfield : UITextField =
    {
        var txt = UITextField()
        txt.placeholder = "Username"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txt.font = UIFont.systemFont(ofSize: 14)
        return txt
    }()
    
    let passwordTextfield : UITextField =
    {
        var txt = UITextField()
        txt.placeholder = "Password"
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.backgroundColor = UIColor(white: 0, alpha: 0.03)
        txt.font = UIFont.systemFont(ofSize: 14)
        txt.isSecureTextEntry = true
        return txt
    }()
    
    let signupButton : UIButton =
    {
        let btn = UIButton()
        btn.setTitle("Sign up", for: .normal)
        btn.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        print("Button done")
        btn.titleLabel?.textColor = .white
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
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
        plusButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        //Constraints of textfield
        
       
        
        
        setUpStackview()
        
        
    }
    
    
    fileprivate func setUpStackview()
    {
        let layoutStack = UIStackView(arrangedSubviews: [emailTextfield,usernameTextfield,passwordTextfield,signupButton])
        
        layoutStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(layoutStack)
        layoutStack.distribution = .fillEqually
        layoutStack.spacing = 15
        layoutStack.axis = .vertical
        
        //Setting up positioning
        NSLayoutConstraint.activate([
            layoutStack.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 30) ,
            layoutStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            layoutStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            layoutStack.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
        
    }


}

