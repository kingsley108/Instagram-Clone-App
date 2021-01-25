//
//  Refactoring.swift
//  InstaClone
//
//  Created by Kingsley Charles on 25/01/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension Database
{
    func fecthUserWithID(uid: String, completion: @escaping (User) -> ())
    {
        let ref = Database.database().reference().child("users").child(uid)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else {return}
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        } withCancel: { (err) in
            print("There is an error fetchng user",err)
            
        }
    }
}
