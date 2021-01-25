
import UIKit
import Firebase
import FirebaseDatabase

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    private let reuseIdentifier = "Cell"
    var posts = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.clearsSelectionOnViewWillAppear = false
        
        collectionView.backgroundColor = .white
        // Register cell classes
        self.collectionView!.register(HomeCustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setUpNavigationTitle()
        fetchPosts()
    }
    
    func setUpNavigationTitle()
    {
        let image = #imageLiteral(resourceName: "logo2")
        navigationItem.titleView = UIImageView(image: image)
        
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

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeCustomCell
        cell?.post = self.posts[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height = (56 + view.frame.width + 110)
        return CGSize(width: view.frame.width, height: height)
    }
}
