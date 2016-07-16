//
//  TextFieldDelegate.swift
//  memeMe_2
//
//  Created by Anna Rogers on 7/7/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "Top" || textField.text == "Bottom" {
            textField.text = ""
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var newText: NSString
        newText = textField.text!
        newText = newText.stringByReplacingCharactersInRange(range, withString: string)
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (textField.text!.isEmpty) && textField.tag == 1 {
            textField.text = "Top"
        } else if (textField.text!.isEmpty) && textField.tag == 2 {
            textField.text = "Bottom"
        }
        return true
    }
    
}
