//
//  ListViewController.swift
//  OnTheMap
//
//  Created by andrew on 30/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var barButtonLogout: UIBarButtonItem!
    @IBOutlet var barButtonRefresh: UIBarButtonItem!
    
    @IBOutlet var barButtonClose: UIBarButtonItem!
    @IBOutlet weak var listView: UITableView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set up bar buttons
     //navigationItem.leftBarButtonItem = barButtonClose
     navigationItem.leftBarButtonItem = barButtonLogout
    
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Loads tableView data.
      //  listView.reloadData()
    }

    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func barButtonClose(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func barButtonLogout(sender: AnyObject) {
        UdacityClient.sharedInstance().udacityLogout { (success: Bool, error: String?) -> Void in
            if success {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.alert_message("Could not log out", messagem:   "Please check your network connection and try again.",  clickm: "Click")
            }
        }
    }


// tidyup of alert - would be better in somewhere it can be better shared - but not sure how
func alert_message( alertm: String, messagem:  String, clickm: String)  {
    // manages the alert messages on a separate thread
    dispatch_async(dispatch_get_main_queue(), {
        let alert = UIAlertController(title: alertm, message: messagem, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: clickm, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    })
}

    
    
    
    // MARK: - TableView Methods
    
    // Set up tableView cells.
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "StudentList"
        let location = Data.sharedInstance().locations[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! UITableViewCell
        
        let firstName = location.firstName
        let lastName = location.lastName
        let mediaURL = location.mediaURL
        
        cell.textLabel!.text = "\(firstName) \(lastName)"
        cell.detailTextLabel?.text = mediaURL
        
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        return cell
    }
    
    // Retrieves number of rows.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Data.sharedInstance().locations == nil {
            self.getStudentLocations()
        }
        return Data.sharedInstance().locations.count
    }
    
    */
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
