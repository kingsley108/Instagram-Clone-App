//
//  MainTabBarController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 15/01/2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let userProfile = UserProfileController(collectionViewLayout: layout)
        
        let userNav = UINavigationController(rootViewController: userProfile)
        
        userNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        userNav.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        tabBar.tintColor = .black
        tabBar.barTintColor = .lightGray
        viewControllers = [userNav]
        userNav.navigationBar.barTintColor = UIColor.lightGray

    }
    

  

}
