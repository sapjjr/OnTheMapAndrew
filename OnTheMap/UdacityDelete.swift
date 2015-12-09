//
//  UdacityDelete.swift
//  OnTheMap
//
//  Created by andrew on 06/10/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//
// This is used for loggin out

/*
JSON Response :

{
"session": {
"id": "1463940997_7b474542a32efb8096ab58ced0b748fe",
"expiration": "2015-07-22T18:16:37.881210Z"
}
}
*/
import UIKit
import Foundation
extension UdacityClient{

    
    // Logout of Udacity Session otherwise known as Delete Session
  func udacityLogOutMethod( completionHandler: (result: Bool, error: String?) -> Void) {
        //  Build the URL
       let url = NSURL(string: Constants.baseURL + Methods.UdacitySession )!
        //let url = NSURL(string: "https://www.udacity.com/api/session" )!
        // Configure the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie! = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in (sharedCookieStorage.cookies! as [NSHTTPCookie]) {
                if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
                }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                print(" gone wrong check Udacity Delete")// Handle error…
        return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
             completionHandler(result: true, error: nil)
            }
        task.resume()
    }
/*
    should return:
    {
    "session": {
    "id": "1463940997_7b474542a32efb8096ab58ced0b748fe",
    "expiration": "2015-07-22T18:16:37.881210Z"
    }
    }
*/


}