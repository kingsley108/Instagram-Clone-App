//
//  Struct.swift
//  InstaClone
//
//  Created by Kingsley Charles on 22/01/2021.
//

import Foundation
struct Posts
{
    var imageUrl: String
    var caption: String
    var username: String
    var aviUrl: String
    
    init(user: User , dict: [String:Any])
    {
        self.imageUrl = dict["imageUrl"] as? String ?? ""
        self.caption = dict["Caption"] as? String ?? ""
        self.username = user.username
        self.aviUrl = user.profleimageUrl
    }
    
}
