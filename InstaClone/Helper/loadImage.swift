//
//  loadImage.swift
//  InstaClone
//
//  Created by Kingsley Charles on 23/01/2021.
//

import UIKit

class loadImage: UIImageView
{
    var urlString: String?
    
    func displayImage(urlString: String)
    {
        self.urlString = urlString
        if let imageUrl = URL(string: urlString)
        {
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                
                if self.urlString != imageUrl.absoluteString {
                    return
                }
                if error != nil {
                    print(error!)
                    return
                }
                
                guard let data = data else {return}
                
                if let downloadedImage = UIImage(data: data)
                {
                    DispatchQueue.main.async  {
                        self.image = downloadedImage}
                }
                
            }).resume()
        }
    }
}
