//
//  LoginViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 16/01/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    let userSignUp: UIButton =
    {
        let btn = UIButton()
        btn.setTitle("Don't have an account sign up", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(navigateSignUp), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(userSignUp)
        userSignUp.anchor(top:nil, left:view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padTop: 0, padLeft: 0, padBottom: 15, padRight: 0, width: 0, height: 50)
        
    }
    
    @objc func navigateSignUp ()
    {
        let signUpVc = RegisterViewController()
        navigationController?.pushViewController(signUpVc, animated: true)
    }
    

   

}
