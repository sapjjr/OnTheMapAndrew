//
//  OTMConvenience.swift
//  OnTheMap
//
//  Created by andrew on 30/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//
import UIKit
import Foundation


extension UdacityClient{
    
    
    func udacityPOSTMethod(parameters:
                [String: AnyObject],
                baseURL: String,
                method: String,
                jsonBody: [String: AnyObject],
                completionHandler: (result: AnyObject!,
                                     error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        // 1. Set the parameters
        let parameters = [String: AnyObject]()
        
        // 2. Build the URL
        let url = NSURL(string: baseURL + method + escapedParameters(parameters))!
        
        // 3. Configure the request
        let request = NSMutableURLRequest(URL: url)
        var jsonError: NSError! = nil
                    if baseURL == Constants.BaseURLStudent {
                        request.HTTPMethod = "POST"
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.addValue(Constants.ParseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
                        request.addValue(Constants.ParseAPIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
                        do {
                            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonBody, options: [])
                        } catch let error as NSError {
                            jsonError = error
                           completionHandler(result: request, error: jsonError)
                            print("\(jsonError)")
                            request.HTTPBody = nil
                            }
            } else {
                        request.HTTPMethod = "POST"
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        do {
                        //request.HTTPBody = "{\"udacity\": {\"username\": \"\(outletEmail)\", \"password\": \"\(outletPassword)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
                            //print("request.HTTPBody: \(request.HTTPBody)")
                            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(jsonBody, options: [])
                            print("jsonBody: \(jsonBody)")
                            /*
                            jsonBody: ["udacity": {
                            password = ???????;
                            username = "andrew.park@ntlworld.com";
                            }]
                            */
                        } catch let error as NSError {
                            jsonError = error
                            //print("jsonError:   \(jsonError)")
                            completionHandler(result: request, error: jsonError)
                            request.HTTPBody = nil
                        }
                    }
             print("request.HTTPBody: \(request.HTTPBody)")
                            
            print("request \(request)---------------------------")
            print("is it working here")
            //let session = NSURLSession.sharedSession()
            print("This is the session data \(session.dataTaskWithRequest(request))---------------------------")
                                        
                           
                                        
        let task = session.dataTaskWithRequest(request) { data, response, taskError in

            
               print("task error: \(taskError)")
                // 5/6. Parse the data
                    if let error = taskError {
                        completionHandler(result: nil, error: taskError)
                        print("task error: \(error)")
                        } else {
                        let newData : NSData?  = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
                        print(" this is the new data   \(newData!)")
                        if baseURL == Constants.baseURL {
                        //let  newData: NSData? = data!.subdataWithRange(NSMakeRange(5, data!.length - 5))
                        print(" baseURL :   \(baseURL)")

                        } else {
                        
                        print(" this is the FAILED  new data\(newData)") // working here---------------------------
                        }
                        print("this is the data before parsing  \(NSString(data: data!, encoding: NSUTF8StringEncoding)!)")
                    //parse with a completionHandler
                    let parsingError: NSError? = nil
                        
                        
                    let parsedResult =  try! NSJSONSerialization.JSONObjectWithData(newData!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                        print("getRequestToken  \(parsedResult)")
                        /*
                            {
                            account =     {
                            key = ?????????;
                            registered = 1;
                            };
                            session =     {
                            expiration = "2015-12-04T09:29:44.937780Z";
                            id = ?????????????????????????;
                            };
                            }
                        andrew.park@ntlworld.com
                            */
                        print ("----------------------------------------------")


                        if let error = parsingError {
                            completionHandler(result: nil, error: parsingError)
                            print("\(error)")
                            print("\(parsingError)")

                        } else {
                    completionHandler(result: parsedResult as! [String: AnyObject], error: nil)
                    print ("This is the parsed result")
                    print(parsedResult["account"]!)
               /*
                            {
                            key = ?????????;;
                            registered = 1;
                            }
               */
                    print("this is the parsedResult session ")
                    print(parsedResult["session"]!)
                /*
                            {
                            expiration = "2015-12-04T09:29:44.937780Z";
                            id = ?????????????????????????;
                            }
                */
                    print ("----------------------------------------------")
                    print("can we get the SESSION ID")
                    print(parsedResult.valueForKey("session")!) // is a tuple
                /*
                            {
                            expiration = "2015-12-04T09:29:44.937780Z";
                            id = ?????????????????????????;
                            }
                */
                    print("can we get the ID")
                    print (parsedResult.valueForKey("session")!["id"]!)
                /*
                            {
                            expiration = "2015-12-04T09:29:44.937780Z";
                            id = ?????????????????????????;
                            }
                */
       
                    let session_ID = parsedResult.valueForKey("session")!["id"]! as! String
                    print ("----------------------------------------------")                    
                    print ("----------------------------------------------")
                    print(session_ID) // this would give just the id
                /*
                            ?????????????????????????????
                */
                    print ("----------------------------------------------")
                            
       
                    }
            }}
        // 7. Start the request
        task.resume()
        return task
    }

    
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            // Make sure that it is a string value
            let stringValue = "\(value)"
            
            // Escape it
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            // Append it
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
        }
