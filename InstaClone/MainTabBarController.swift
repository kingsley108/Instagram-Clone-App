//
//  MainTabBarController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 15/01/2021.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var index : Int?
    override func viewDidLoad() {
        self.delegate = self
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                let loginController = LoginViewController()
                let navController = UINavigationController(rootViewController: loginController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        setUpVc()
        
}
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
        index = viewControllers?.firstIndex(of: viewController)
        if self.index == 2
        {
            let photoVc = PhotoController(collectionViewLayout:UICollectionViewFlowLayout())
            let photoNav = UINavigationController(rootViewController: photoVc)
            photoNav.modalPresentationStyle = .fullScreen
            present(photoNav, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    func setUpVc ()
    {
        //Home Profile
        let homeVc = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        let homeNav = templateController(selectedimage: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"), vc: homeVc)

        //Search Navigator
        let searchController = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        let searchNav = templateController(selectedimage: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"), vc: searchController)

        let photoNav = templateController(selectedimage: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"))

        let likesNav = templateController(selectedimage: #imageLiteral(resourceName: "like_selected"), unselectedImage: #imageLiteral(resourceName: "like_unselected"))

        //UserProfile Navigator
        let layout = UICollectionViewFlowLayout()
        let userProfile = UserProfileController(collectionViewLayout: layout)
        let userNav = UINavigationController(rootViewController: userProfile)
        
        viewControllers = [homeNav,searchNav,photoNav,likesNav,userNav]
        userNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        userNav.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        tabBar.tintColor = .black
        
        //Iterate through tabBar items
        for item in self.tabBar.items! as [UITabBarItem]
        {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
        
    }
     
    func templateController(selectedimage: UIImage , unselectedImage: UIImage, vc : UIViewController? = UIViewController ()) -> UINavigationController
    {
        let vc = vc
        let templateNav = UINavigationController(rootViewController: vc!)
        templateNav.tabBarItem.selectedImage = selectedimage
        templateNav.tabBarItem.image = unselectedImage
        return templateNav
        
        
    }
    

  

}
