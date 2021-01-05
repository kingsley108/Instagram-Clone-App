//
//  Extension.swift
//  InstaClone
//
//  Created by Kingsley Charles on 05/01/2021.
//
import UIKit
import Foundation

extension UIColor
{
    static func rgb(red : CGFloat , green : CGFloat , blue : CGFloat) -> UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
    }
}

extension UIView
{
    func anchor(top : NSLayoutYAxisAnchor? , left :NSLayoutXAxisAnchor? ,bottom:NSLayoutYAxisAnchor?,right:NSLayoutXAxisAnchor?, padTop : CGFloat , padLeft :CGFloat , padBottom : CGFloat,padRight : CGFloat , width :CGFloat , height : CGFloat)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topC = top {self.topAnchor.constraint(equalTo: topC, constant: padTop).isActive = true}
        
        if let bottomC = bottom{self.bottomAnchor.constraint(equalTo: bottomC, constant: padBottom).isActive = true}
        
        if let rightC = right{self.rightAnchor.constraint(equalTo: rightC, constant: padRight).isActive = true}
        
        if let leftC = left {self.leftAnchor.constraint(equalTo: leftC, constant: padLeft).isActive = true}
        
        if height != 0{self.heightAnchor.constraint(equalToConstant: height).isActive = true}
        
        if width != 0 {self.widthAnchor.constraint(equalToConstant: width).isActive = true}
       
        
  
    }
    
}
