//
//  loadImage.swift
//  InstaClone
//
//  Created by Kingsley Charles on 23/01/2021.
//

import UIKit

class LoadImage: UIImageView
{
    var urlString: String?
    var cache = [String: Data]()
    
    func displayImage(urlString: String)
    {
        if let data = cache[urlString]
        {
            DispatchQueue.main.async{self.image = UIImage(data: data)}
            return
        }
        
        self.urlString = urlString
        if let imageUrl = URL(string: urlString)
        {
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                if self.urlString == imageUrl.absoluteString
                {
                    guard let data = data else {return}
                    
                    self.cache[urlString] = data
                    
                    if let downloadedImage = UIImage(data: data)
                    {
                        DispatchQueue.main.async  {self.image = downloadedImage}
                    }
                }
                if error != nil {
                    print(error!)
                    return
                }
            }).resume()
        }
    }
}
