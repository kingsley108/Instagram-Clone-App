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
                print(self.urlString)
                print(imageUrl.absoluteString)
                if self.urlString == imageUrl.absoluteString
                {
                    guard let data = data else {return}
                    
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
