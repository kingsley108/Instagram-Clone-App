
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth



class UserProfileController: UICollectionViewController , UICollectionViewDelegateFlowLayout
{
    let reuseIdentifier = "Cell"
    let headerIdentifier = "headerId"
    var user : User?
    var posts = [Posts]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        setupItems()
        fetchPosts()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(UserProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        collectionView.register(UserPostsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
    }
    
    //MARK: Function to fetch the username
    
    func fetchUsers()
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("users").child(uid)
        ref.queryOrdered(byChild: "Creation Date").observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:Any]
            {
                let user = User(dictionary: dictionary)
                self.user = user
                guard let username = self.user?.username else {return}
                DispatchQueue.main.async
                {
                    self.navigationItem.title = username
                }
                
                self.collectionView.reloadData()
            }
            
        } withCancel: { (err) in
            print("There is an error fetchng user",err)
            
        }
    }
    
    func fetchPosts()
    {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference()
        ref.child("posts").child(uid).queryOrdered(byChild: "Creation Date").observe(.value) { (snapshot) in
            self.posts.removeAll()
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            dictionary.forEach { (key,val) in
                guard let postDictionary = val as? [String:Any] else {return}
                let userPost = Posts(dict: postDictionary)
                self.posts.insert(userPost, at: 0)
            }
            self.collectionView.reloadData()
           
        } withCancel: { (err) in
            print("Failed to get posts from user" , err)
        }
    }
    
    //MARK: Handle Logging out
    
    fileprivate func setupItems()
    {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style:.plain , target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    @objc func handleLogOut()
    {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "Log Out", style: .default) { (UIAlertAction) in
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            let loginVc = LoginViewController()
            let navController = UINavigationController(rootViewController: loginVc)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(logout)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: UICollectionViewDataMethods
    
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as? UserProfileHeaderCell
        headerCell?.backgroundColor = .white
        
        headerCell?.user = self.user
        
        return headerCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width:(view.window?.frame.width)!, height: 200)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UserPostsCell
        
        cell?.post = posts[indexPath.item]
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let size = (view.frame.width - 2)/3
        return CGSize(width: size, height: size)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
