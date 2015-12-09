//
//  Escaped.swift
//  OnTheMap
//
//  Created by andrew on 02/12/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit
import Foundation



extension UdacityClient  {
    
func escapedParameters(parameters: [String : AnyObject]) -> String {
    
    // This helps construc the URL string. It takes an array and returns a string
    
    var urlVars = [String]()
    
    for (key, value) in parameters {
        
        /* Make sure that it is a string value */
        let stringValue = "\(value)"
        
        /* Escape it */
        let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        /* Append it */
        urlVars += [key + "=" + "\(escapedValue!)"]
        
    }
    
    return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
}

}
