//
//  SearchViewController.swift
//  InstaClone
//
//  Created by Kingsley Charles on 27/01/2021.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class SearchController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UISearchDisplayDelegate
{
    var users = [User]()
    var filteredUsers = [User]()
    
    lazy var searchBar: UISearchBar =
    {
        let searchBar = UISearchBar()
       searchBar.placeholder = "Enter Username"
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(SearchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        navigationItem.titleView = searchBar
        self.collectionView.alwaysBounceVertical = true
        fetchUsers()
    }


    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return filteredUsers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? SearchCell
        
        cell?.user = self.filteredUsers[indexPath.row]
    
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.width, height: 66)
        
    }
    
    func fetchUsers()
    {
        let ref = Database.database().reference()
        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
            
            guard let dictionary =  snapshot.value as? [String:Any] else {return}
            
            dictionary.forEach { (key,value) in
                guard let userValues = value as? [String: Any] else {return}
                let user = User(uid: key, dictionary: userValues)
                self.users.append(user)
            }
            self.filteredUsers = self.users
            self.collectionView.reloadData()
        }
        
    }
    
    // MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty
        {
            filteredUsers = users
            collectionView.reloadData()
        }
        else
        {
            filteredUsers.removeAll()
            for i in 0...users.count - 1
            {
                if (users[i].username.range(of: searchText, options: .caseInsensitive) != nil)
                {
                    let potentialUser = users[i]
                    filteredUsers.append(potentialUser)
                }
            }
            filteredUsers.sort {$0.username < $1.username}
            collectionView.reloadData()
        }
    }
  

}
