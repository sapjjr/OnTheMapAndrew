//
//  TextFieldDelegate.swift
//  OnTheMap
//
//  Created by andrew on 04/10/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // Dismisses keyboard when user taps "return".
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
}

