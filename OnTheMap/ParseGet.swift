//
//  ParseGet.swift
//  OnTheMap
//
//  Created by andrew on 27/10/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit
import Foundation


extension UdacityClient{
    
    
    
    func parseGetMethod( parameters: [String : AnyObject], baseURL: String, method: String, key: String, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        
        let urlString = baseURL + "/" + method  //+ key
        print("UdacityParseGet ---urlString  ---\(urlString)       ----")
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        var parsedResult: AnyObject? = nil
        print("1--------------------------------------------------")
        // Make the request
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            
            
            // gard was there an error-------------
            guard (error == nil) else {
                print("UdacityParseGet error 36---\(error)")
                completionHandler(result: nil, error: error)
                return
            }
            
            print("UdacityParseGet --- response    ----   \(response)")
            // GUARD:  any data returned -------------
            
            
            // Remove these characters ==> ")]}'\n" <== these are getting included in responses from Udacity API
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!.subdataWithRange(NSMakeRange(5, data!.length - 5)), options: .AllowFragments)
            }
            catch let error as NSError {
                completionHandler(result: nil, error: error)
                print("UdacityParseGet error ---\(error)")
            }
            
            completionHandler(result: parsedResult, error: nil)
            
            
            print("")
            print("")
            print("UdacityParseGet ParsedResult 61 \(parsedResult)   ------------")
            print("3")
            
            
        }
        // 7. Start the request
        
        
        print("UdacityParseGet  parsedResult 69 --------    \(parsedResult)")
        task.resume()
        
        return task
    }
}
