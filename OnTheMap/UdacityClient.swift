//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by andrew on 28/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit


class UdacityClient: NSObject{
    
    // Shared session
    var session: NSURLSession
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    let baseURL: String = Constants.baseURL
    //let BaseURL: String = "https://www.udacity.com/api/session"
    let PUDURL: String = Constants.PUDURL
        //Public User Data URL
    
    func getSessionID(outletEmail: String, outletPassword: String, completionHandler: (success: Bool, errorString: String?) -> Void)  {
        // variables
        
        let parameters = [String: AnyObject]()
        let baseURL = Constants.baseURL
        let method = Methods.UdacitySession
        let jsonBody = ["udacity": ["username": outletEmail, "password" : outletPassword]]
        
        
        self.udacityPOSTMethod(parameters, baseURL: baseURL, method: method, jsonBody: jsonBody) { result, error in
                // Send the desired value(s) to completion handler
                if let error = error {
                    completionHandler(success: false, errorString: "Please check your network connection and try again.\(error)")
                } else {
                    if let resultDictionary = result.valueForKey(UdacityClient.JsonConstants.Account) as? NSDictionary {
                        if let userID = resultDictionary.valueForKey(UdacityClient.JsonConstants.UserID) as? String {
                            NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "UdacityUserID")
                            completionHandler(success: true, errorString: "successful")
                        }
                    } else {
                        completionHandler(success: false, errorString: "Username or password is incorrect.")
                        print("Could not find \(JsonConstants.Account) in \(result)")
                    }
                }
        }
    }

    
    func udacityLogout(completionHandler: (success: Bool, error: String?) -> Void) {
        
        
        
        // Build URL & configure Request
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.baseURL)!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies as [NSHTTPCookie]! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }// Make Request
        task.resume()
    }
  
    
    
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

    class func sharedInstance() -> UdacityClient {
        
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        
        return Singleton.sharedInstance
    }
}