//
//  OTMContstants.swift
//  OnTheMap
//
//  Created by andrew on 24/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import Foundation
import UIKit



class OTMConstants: UIResponder, UIApplicationDelegate  {

// Constants

let baseURLString =  "https://www.udacity.com/api/session"


/* Need these for login */
var requestToken: String? = nil
var sessionID: String? = nil
var userID: Int? = nil

/* Configuration for TheMovieDB, we'll take care of this for you =)... */
var config = Config()



}

extension OTMConstants {
    
    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        
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
