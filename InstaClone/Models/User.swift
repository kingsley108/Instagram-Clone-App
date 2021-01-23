
import Foundation
struct User {
    var username : String
    var profleimageUrl : String

    
    init(dictionary: [String : Any])
    {
        self.username = dictionary["username"] as! String
        self.profleimageUrl = dictionary["profileURL"] as! String
    }
}
