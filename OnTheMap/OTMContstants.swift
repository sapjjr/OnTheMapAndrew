//
//  OTMContstants.swift
//  OnTheMap
//
//  Created by andrew on 24/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

extension UdacityClient  {

    struct UdacityAccount {
        static let UdacitySessionID: String? = "sessionID"
        // var accountKey: Int? = nil
        static let UdacityAcountKey: String? = "accountKey"
    }

    struct Constants {
    
        static let baseURL : String =  "https://www.udacity.com/api"
        static let BaseURLStudent : String = "https://api.parse.com/1/classes/StudentLocation"
        static let PUDURL : String = "https://www.udacity.com/api/users/3903878747"
        
        // URL Keys
        static let ParseAppID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ParseAPIKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct Methods {
        // URL Endings
        static let UdacitySession: String = "/session"
        static let FacebookSession: String = "/session"
        static let UdacityData: String = "/users/"
        static let UpdatedAt: String = "?order=-updatedAt"
     //   static let UpdateLocation: String = "/" + Data.sharedInstance().objectID
    }

    struct JsonConstants {
        // Udacity General
        static let Account = "account"
        static let Results = "results"
        static let UserID = "key"
        
        // Udacity User
        static let User = "user"
        static let UserFirstName = "first_name"
        static let UserLastName = "last_name"
        
        // Student Locations
        static let CreatedAt = "createdAt"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let UpdatedAt = "updatedAt"
    }


}


    

