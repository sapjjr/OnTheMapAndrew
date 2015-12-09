//
//  UdacityPost.swift
//  OnTheMap
//
//  Created by andrew on 06/10/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//
import UIKit
import Foundation

extension UdacityClient{
    // this should get the session ID
    
    func udacityPOSTMethod(
                    parameters          : [String: AnyObject],
                    baseURL             : String,
                    method              : String,
                    jsonBody            : [String: AnyObject],
                    completionHandler   : (result: Bool, resultDictionary: [String: AnyObject]?, error: NSError?) -> Void) -> NSURLSessionDataTask {
            
            // 1. Set the parameters
            let parameters = [String: AnyObject]()
            print("UdacityPost - parameters  ---\(parameters)----")
                
                // 2. Build the URL\
            let session = NSURLSession.sharedSession()
            
            let urlString = baseURL +  method + escapedParameters(parameters)
            let url = NSURL(string: urlString)!
                
            // 3. Configure the request
                
                
            let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                do {
                    request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(jsonBody, options: [])
                    print("UdacityPost jsonBody: \(jsonBody)") //jsonBody: ["udacity": { password = ???????; username = "andrew.park@ntlworld.com"; }]
                }
                
            /* 4. Make the request */
                let task = session.dataTaskWithRequest(request) { (data, response, error) in
			
			/* GUARD: Was there an error? */
			guard (error == nil) else {
				print("There was an error with your request: \(error)")
				completionHandler(result: false, resultDictionary: nil, error: error)
				return
			}
			
			/* GUARD: Was there any data returned? */
			guard let data = data else {
				print("No data was returned by the request!")
				return
			}
			
			/* GUARD: Did we get a successful 2XX response? */
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
				if let response = response as? NSHTTPURLResponse {
					print("Invalid response! Status code: \(response.statusCode)!")
				} else if let response = response {
					print("Invalid response! Response: \(response)!")
				} else {
					print("Invalid response!")
				}
                UdacityClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
                
                //UdacityClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
				return
			}
			
			/* 5/6. Parse the data and use the data (happens in completion handler) */
            UdacityClient.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)

		}
		
		/* 7. Start the request */
		task.resume()
		
		return task
	}

    //{"current_time": "2015-12-02T13:11:08.227760Z", "account": {"registered": true, "key": "u31487963"}, "session": {"id": "1480430415S05eb6aee103fa21ec5cbcdc0ec0c4bb7", "expiration": "2016-01-29T14:40:15.897710Z"}, "current_seconds_since_epoch": 1449061868.2277701}
    
    
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: Bool, resultDictionary: [String: AnyObject]?, error: NSError?) -> Void) {
        
        do {
            let newParsedResult = try NSJSONSerialization.JSONObjectWithData(data.subdataWithRange(NSMakeRange(5, data.length - 5)), options: .AllowFragments) as? [String: AnyObject]
            completionHandler(result: true, resultDictionary: newParsedResult, error: nil)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandler(result: false, resultDictionary: nil, error: NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        
    }
    
    
    
    
}