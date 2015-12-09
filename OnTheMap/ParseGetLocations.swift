//
//  UdacityGet.swift
//  OnTheMap
//
//  Created by andrew on 06/10/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit
import Foundation


extension UdacityClient{

    func GetLocations(completionHandler: (success: Bool, error: NSError?) -> () ) {
        
        
        // let parameters = [String: AnyObject]()
        
        let urlString = Constants.baseURLStudent +  Methods.StudentLocation //+ escapedParameters(parameters)
        
        
        print("GetLocations ---urlString  ---\(urlString)       ----")
        let url = NSURL(string: urlString)!
        
        let request = NSMutableURLRequest(URL: url)
        
        
        // Make the request
        
        request.addValue(Constants.AppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Constants.ParseAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = NSURLSession.sharedSession()
        //  let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        // request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        //  request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            
            //    dispatch_async(dispatch_get_main_queue() ) {
            
            guard error == nil else {
                completionHandler(success: false, error: error)
                return
            }
            //print("data line 45.......\(data)")
            
            self.parseLocationData(data!) { success, error in
                completionHandler(success: true, error: nil)
                
                // print("has Get Locations been called if so")
                // print ("students------------\(self.students)")
                
                /*
                [OnTheMap.StudentData(createdAt: "2015-12-05T10:49:54.131Z", firstName: "John", lastName: "Doe", latitude: 37.386052, longitude: -122.083851, mapString: "Mountain View, CA", mediaURL: "https://udacity.com", objectID: "F1lK288OBd", uniqueKey: "1234", updatedAt: "2015-12-05T10:49:54.131Z"), OnTheMap.StudentData(createdAt: "2015-12-04T21:31:33.451Z", firstName: "Patrick", lastName: "Bellot", latitude: 30.369834, longitude: -89.091582, mapString: "Gulfport,ms", mediaURL: "www.swift-file.com", objectID: "rzDWhr9gsY", uniqueKey: "4624378622", updatedAt: "2015-12-04T21:31:33.451Z"),
                
                */
            }
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding)  )
            /*
            Optional({"results":[{"createdAt":"2015-12-05T10:49:54.131Z","firstName":"John","lastName":"Doe","latitude":37.386052,"longitude":-122.083851,"mapString":"Mountain View, CA","mediaURL":"https://udacity.com","objectId":"F1lK288OBd","uniqueKey":"1234","updatedAt":"2015-12-05T10:49:54.131Z"},
            */
            
            // }
        }
        
        task.resume()
    }
    
    
    
    
    func parseLocationData(data: NSData, completionHandler: (success: Bool, errorString: String?) -> Void) {
        students.removeAll()
        // Get the users JSON data
        do {
            let usersData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
            
            if let locations = usersData!["results"] as? [NSDictionary] {
                
                for loc in locations {
                    
                    students.append(StudentData(dictionary: loc))
                    
                }
            } else {
                // Error getting the dictionary from JSON data
                completionHandler(success: false, errorString: "Unable to locate results in JSON data")
                return
            }
        } catch {
            completionHandler(success: false, errorString: "Could not parse student data")
        }
        // Return successful
        completionHandler(success: true, errorString: nil)
        //print( "---96-----students from parselocationData \(students)" )
        
    }

}
