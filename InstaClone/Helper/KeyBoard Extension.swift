//
//  KeyBoard Extension.swift
//  InstaClone
//
//  Created by Kingsley Charles on 16/01/2021.
//

import Foundation
import UIKit

extension RegisterViewController: UITextFieldDelegate
{
    /**
         * Called when 'return' key pressed. return NO to ignore.
         */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }


       /**
        * Called when the user click on the view (outside the UITextField).
        */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension LoginViewController: UITextFieldDelegate
{
    /**
         * Called when 'return' key pressed. return NO to ignore.
         */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }


       /**
        * Called when the user click on the view (outside the UITextField).
        */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
