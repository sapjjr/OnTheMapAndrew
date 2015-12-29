//
//  MapViewController.swift
//  OnTheMap
//
//  Created by andrew on 30/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UdacityClient.sharedInstance.GetLocations() { success, error in
            if success {  //x2
                
                self.mapView.addAnnotations( UdacityClient.sharedInstance.studentAnnotations() )
                
            } else {
                print ("Failure from ViewDidLoad \(error ) -- \(UdacityClient.sharedInstance.students.count) ")
                
            }

        
        
        
        
        
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
