//
//  GetUserPublicData.swift
//  OnTheMap
//
//  Created by andrew on 02/12/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import Foundation
import UIKit



extension UdacityClient  {
    
    
    
func udacityGetPublicUserMethod(completionHandler: (success: Bool, error: NSError?) -> Void) {
    
    let parameters = [String: AnyObject]()
    let baseURL = Constants.baseURL
    let method = Methods.UdacityData
   // let key = NSUserDefaults.standardUserDefaults().stringForKey("KeyID")
    
    let urlString  = baseURL + method + escapedParameters(parameters)
    let url = NSURL(string: urlString)!

    
    let request = NSMutableURLRequest(URL: url)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { data, response, error in
        if error != nil {
            
            print("GetPublicUserData Theres is an error \(error)")
            return
        }
        let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
        print(NSString(data: newData, encoding: NSUTF8StringEncoding))
    }
    task.resume()
    
    /*
    let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/3903878747")!)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) { data, response, error in
        if error != nil { // Handle error...
            return
        }
        let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
        println(NSString(data: newData, encoding: NSUTF8StringEncoding))
    }
    task.resume()
    */
    
}
}
