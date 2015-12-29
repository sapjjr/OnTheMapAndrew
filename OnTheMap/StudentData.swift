//  StudentData.swift
//  OnTheMap
//  Created by andrew on 02/10/2015.
//  Copyright © 2015 Firekite. All rights reserved.

import Foundation
import MapKit


struct StudentData {
    
    var createdAt : String //= ""
    var firstName : String//= ""
    var lastName  : String//= ""
    var latitude  : Double//= 0.0
    var longitude : Double//= 0.0
    var mapString : String//= ""
    var mediaURL  : String//= ""
    var objectId  : String//= ""
    var uniqueKey : String//= ""
    var updatedAt : String//= ""
    
    let annotation = MKPointAnnotation()
    
    //Location from  dictionary
    init(dictionary: NSDictionary) {
        self.createdAt = dictionary["createdAt"] as! String
        self.firstName = dictionary["firstName"] as! String
        self.lastName  = dictionary["lastName"]  as! String
        self.latitude  = dictionary["latitude"]  as! Double
        self.longitude = dictionary["longitude"] as! Double
        self.mapString = dictionary["mapString"] as! String
        self.mediaURL  = dictionary["mediaURL"]  as! String
        self.objectId  = dictionary["objectId"]  as! String
        self.uniqueKey = dictionary["uniqueKey"] as! String
        self.updatedAt = dictionary["updatedAt"] as! String
    }
 
    func setAnnotation(data: NSDictionary) {
        let lat = CLLocationDegrees(data["latitude"] as! Double)
        let long = CLLocationDegrees(data["longitude"] as! Double)
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = "\(firstName) \(lastName)"
        annotation.subtitle = mediaURL
    }
    

}

