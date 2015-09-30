//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by andrew on 28/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit


class UdacityClient: NSObject{
   
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
   // var outletEmail = "andrew.park@ntlworld.com"
   // var outletPassword = "jessica307"
    var sessionID: String = ""
    //outletEmail :String, _ outletPassword: String
    let BaseURL: String = "https://www.udacity.com/api/session"
    let PUDURL: String = "https://www.udacity.com/api/users/3903878747"
        //Public User Data URL
    

    
    
    func getSessionID(outletEmail: String, outletPassword: String, completionHandler: (success: Bool, errorString: String?) -> Void) -> String {

        
        let request = NSMutableURLRequest(URL: NSURL(string: BaseURL)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(outletEmail)\", \"password\": \"\(outletPassword)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        //print("\(outletEmail.text)","\(outletPassword.text)")

        let session = NSURLSession.sharedSession()

        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard(error == nil) else {
                dispatch_async(dispatch_get_main_queue()) {
   //                 self.setUIEnabled(enabled: true)
   //                 self.outletError.text = "Login Failed (Request Token)."
                }
                completionHandler(success: false, errorString: "There was an error with your request: \(error)")
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                dispatch_async(dispatch_get_main_queue()) {
                }
                if let response = response as? NSHTTPURLResponse {
                    completionHandler(success: false, errorString: "Your request returned an invalid response! Status code: \(response.statusCode)!")
                    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
                }
                return
            }
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                dispatch_async(dispatch_get_main_queue()) {
                }
                completionHandler(success: false, errorString: "No data was returned by the request!")
                print("No data was returned by the request!")
                return
            }
            // Parse the Data
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments) as! NSDictionary// converts raw data to a foundation object  needs to be converted to an NSDictioary (Udacity 2.9)

                // print(parsedResult["account"]!)
                /*
                Optional({
                key = u31487963;
                registered = 1;
                })
                */
                //print(parsedResult["session"]!)
                /*
                Optional({
                expiration = "2015-11-27T18:26:28.081520Z";
                id = 1475000788Sb52cc09ae89b6d54970c276e6f6fbac0;
                })
                */
                //  print (parsedResult.valueForKey("session")!) // is a tuple
                /*
                {
                expiration = "2015-11-27T18:26:28.081520Z";
                id = 1475000788Sb52cc09ae89b6d54970c276e6f6fbac0;
                }
                */
                //  print (parsedResult.valueForKey("session")!["id"]!)
                /*
                Optional(1475000788Sb52cc09ae89b6d54970c276e6f6fbac0)
                */
                //let session_ID = parsedResult.valueForKey("session")!["id"]! as! String
                // print(session_ID) // this would give just the id
                
            } catch {
                parsedResult = nil
                dispatch_async(dispatch_get_main_queue()) {
                }
                completionHandler(success: false, errorString: "Could not parse the data as JSON: '\(newData)'")
                print("Could not parse the data as JSON: '\(newData)'")
                return
            }
            
            /* GUARD: Did  return an error? */
            guard (parsedResult.objectForKey("status_code") == nil) else {
                dispatch_async(dispatch_get_main_queue()) {
                }
                completionHandler(success: false, errorString: "Udacity returned an error. See the status_code and status_message in \(parsedResult)")
                print("Udacity returned an error. See the status_code and status_message in \(parsedResult)")
                return
            }
            
            /* GUARD: Is the sessionID in parsedResult? */
            guard let sessionID = parsedResult.valueForKey("session")!["id"]! as! String! else {
                dispatch_async(dispatch_get_main_queue()) {
                }
                completionHandler(success: false, errorString: "Cannot find sessionID in \(parsedResult)")
                print("Cannot find sessionID in \(parsedResult)")
                return
            }
            
            /* 6. Use the data! */
            completionHandler(success: true, errorString: "successful")
            print("This is the sessionID   \(sessionID)")
            
            
            /* Get the app delegate */
            self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            self.appDelegate.sessionID = sessionID
        }
        
        /* 7. Start the request */
        task.resume()
        return sessionID
        
        
        
        //  (NSString(data: data!, encoding: NSUTF8StringEncoding)!) as Dictionary
        
    }
    
    /* example response
    {
    "account":{
    "registered":true,
    "key":"3903878747"
    },
    "session":{
    "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
    "expiration":"2015-05-10T16:48:30.760460Z"
    }
    }
    with hardcoded get: 
    
    Optional({
    "account": {
    "registered": true, 
    "key": "u31487963"}, 
    "session": {
    "id": "1474809878S4ebd10b9499a7a6804b0120c50266403", 
    "expiration": "2015-11-25T13:24:38.737750Z"}})
    */
    
// Mark sharedinstance
// This way saves memory apparently? it is astatic constant of a nested struct as a class constant -  no explanation in course!
    class func sharedInstance() -> UdacityClient {
        
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        
        return Singleton.sharedInstance
    }
    
    
    
    
}
