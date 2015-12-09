//
//  UdacityContstants.swift
//  OnTheMap
//
//  Created by andrew on 24/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

extension UdacityClient  {

    
    
    
    //extension adds a static variable
    // a static is a it’s a shared property between all objects of that class that can’t be overridden by subclasses singletom

    struct UdacitySession {
        static let sessionID = "sessionID" // "1478013715S3c298ea5a86e802312e1da520da94502" //"sessionID" //
        static let KeyID     =  "key"//  "u31487963" //
        static let Account = "account"
        static let User     = "user"
        static let Results = "results"

        static let UserFirstName = "first_name"
        static let UserLastName = "last_name"

    }

    struct Constants {
    
        static let baseURL : String =  "https://www.udacity.com/api"
        static let baseURLStudent : String = "https://api.parse.com/1/classes"
        
        // URL Keys
        static let AppID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ParseAPIKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"

   
    }
    
    struct Methods {
        // URL Endings
        static let StudentLocation = "/StudentLocation?limit=100"
        static let UdacitySession: String = "/session"
        static let UdacityData: String = "/users/"
        static let UpdatedAt: String = "?order=-updatedAt"
     //   static let UpdateLocation: String = "/" + Data.sharedInstance().objectID
    }

    
}


    

