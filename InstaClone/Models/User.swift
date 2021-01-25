
import Foundation
struct User {
    var username : String
    var profleimageUrl : String
    var userId: String

    
    init(uid: String,dictionary: [String : Any])
    {
        self.username = dictionary["username"] as! String
        self.profleimageUrl = dictionary["profileURL"] as! String
        self.userId = uid
    }
}
