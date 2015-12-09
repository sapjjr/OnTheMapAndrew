//
//  ListViewController.swift
//  OnTheMap
//
//  Created by andrew on 30/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var barButtonLogout: UIBarButtonItem!
    @IBOutlet var barButtonRefresh: UIBarButtonItem!
    @IBOutlet var barButtonClose: UIBarButtonItem!
   @IBOutlet weak var listView: UITableView!
    
    var delegate = self

 //   let students : [StudentData] = UdacityClient.sharedInstance.students
    var students : [StudentData] = UdacityClient.sharedInstance.students
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //   dispatch_async(dispatch_get_main_queue() ) {
        UdacityClient.sharedInstance.GetLocations() { success, error in
            
            if success {
               
                self.students = UdacityClient.sharedInstance.students
                print ("Success from ViewDidLoad  \(error ) -- \(UdacityClient.sharedInstance.students.count)")
                print ("Success  ---1--  -- \(UdacityClient.sharedInstance.students[1])")
                      print ("         ---1--  -- ")
                      print ("         ---1-- last name -- \(UdacityClient.sharedInstance.students[1].lastName)")
                      print ("         ---1--  students.count --- \(self.students[1].firstName)")
                
                
                print("ListView--  self.students.count-- \(self.students.count)  -UdacityClient.sharedInstance.students --  \(UdacityClient.sharedInstance.students.count)")
                
                //self.students  = UdacityClient.sharedInstance.students
                
            } else {
                print ("Failure from ViewDidLoad \(error ) -- \(UdacityClient.sharedInstance.students.count) ")
            
        }
        
                 }
     //   }
        //set up bar buttons
     navigationItem.leftBarButtonItem = barButtonLogout
    //self.navigationItem.setRightBarButtonItems([refreshButton, postButton], animated: true)
        // Connect the table to the student data source
        
        self.listView!.dataSource = self
        self.listView.delegate = self
        
    }
    
    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func barButtonClose(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func barButtonLogout(sender: AnyObject) {
        UdacityClient.sharedInstance.udacityLogOutMethod { (result: Bool, error: String?) -> Void in
        if result {
        self.dismissViewControllerAnimated(true, completion: nil)
        } else {
        self.alert_message("Could not log out", messagem: "Please check your network connection and try again.", clickm: "Click")
    
        }
        }
    }
   

// tidyup of alert - would be better in somewhere it can be better shared - but not sure how
func alert_message(alertm: String, messagem:  String, clickm: String)  {
    // manages the alert messages on a separate thread
    dispatch_async(dispatch_get_main_queue(), {
        let alert = UIAlertController(title: alertm, message: messagem, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: clickm, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    })
}

    //  TableView Methods-----------------------------------------------------------------
    //-------------------------------------------------------------------------------------------

    // Set up tableView cells.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

            //let  location    = self.students[indexPath.row]
       let location    = UdacityClient.sharedInstance.students[indexPath.row]

        print ("location  \(location)")
        
        let cell    =  tableView.dequeueReusableCellWithIdentifier("StudentListViewCell") as UITableViewCell!
        
        let firstName = location.firstName
        let lastName = location.lastName
        let mediaURL = location.mediaURL
        
       // cell!.textLabel!.text = "\(location.firstName) \(location.lastName)"
        
            cell!.textLabel!
         cell!.textLabel!.text = "\(firstName) \(lastName)"
         cell!.detailTextLabel?.text = mediaURL
        
         cell!.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        print ("cell details \(firstName) \(lastName) \(mediaURL)")

       
        return cell
    }


    // Retrieves number of rows.
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        print("ListView-- students.count  --- \(students.count) ------  self.students.count-- \(self.students.count)  -UdacityClient.sharedInstance.students --  \(UdacityClient.sharedInstance.students.count)")

        
        
         return UdacityClient.sharedInstance.students.count
        //    return self.students.count
        
    }

    
    // Displays error message alert view.
    func displayError(title: String, errorString: String) {
        dispatch_async(dispatch_get_main_queue()) {
            let alertController = UIAlertController(title: title, message: errorString, preferredStyle: .Alert)
            let okAction = UIAlertAction (title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // Displays error message alert view with completion handler.
    func displayErrorWithHandler(title: String, errorString: String) {
        dispatch_async(dispatch_get_main_queue()) {
            let alertController = UIAlertController(title: title, message: errorString, preferredStyle: .Alert)
            let okAction = UIAlertAction (title: "OK", style: UIAlertActionStyle.Default) { (action) in
                //let storyboard = self.storyboard
                let controller = self.storyboard?.instantiateViewControllerWithIdentifier("Post View") as! PostViewController
                
                self.presentViewController(controller, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction (title: "Cancel", style: UIAlertActionStyle.Destructive, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }


}











