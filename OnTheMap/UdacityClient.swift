//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by andrew on 28/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//
import Foundation
import UIKit


class UdacityClient: NSObject{
    
    static let sharedInstance = UdacityClient()
    var students : [StudentData] = []
    var locations = []
    
    // Shared session
    var session: NSURLSession
    var sessionID : String? = nil
    var userID : Int? = nil
   
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }

    
    func getSessionID(outletEmail: String, outletPassword: String, completionHandler: (success: Bool, errorString: String?) -> Void)  {
        // variables
        
        let parameters = [String: AnyObject]()
        let baseURL = Constants.baseURL
        let method = Methods.UdacitySession
        let jsonBody  = ["udacity": ["username": outletEmail, "password" : outletPassword]]
        
            
       udacityPOSTMethod(parameters, baseURL: baseURL, method: method,   jsonBody: jsonBody)  { (result, resultDictionary, error) in

            /* GUARD: Was there an error? */
            guard (error == nil) else {
                completionHandler(success: false, errorString: error?.localizedDescription)
                return
            }
            
            /* GUARD: Was there a session key */
            guard let session = resultDictionary!["session"] where resultDictionary!["session"] != nil else {
                completionHandler(success: false, errorString: resultDictionary!["error"] as? String)
                return
            }
            
            if let session = session as? [String: AnyObject] {
                self.sessionID = session["id"] as? String
                completionHandler(success: true, errorString: nil)
            }
        }
    }

}








