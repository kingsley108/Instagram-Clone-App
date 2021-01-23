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
    
    init(dict: [String:Any])
    {
        self.imageUrl = dict["imageUrl"] as? String ?? ""
        self.caption = dict["capton"] as? String ?? ""
    }
    
}
