//: Playground - noun: a place where people can play

//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by andrew on 23/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var outletEmail: UITextField!
    @IBOutlet weak var outletPassword: UITextField!
    @IBOutlet weak var outletError: UILabel!
    @IBOutlet weak var outletLogin: UIButton!
    @IBOutlet weak var outletSignUp: UIButton!
    
    
    
    var appDelegate: AppDelegate!
    var session: NSURLSession!
    // keyboard functionality
    var backgroundGradient: CAGradientLayer? = nil
    var tapRecognizer: UITapGestureRecognizer? = nil
    var keyboardAdjusted = false
    var lastKeyboardOffset : CGFloat = 0.0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
        self.configureUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // need to enable keyboard to appear
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addKeyboardDismissRecognizer()
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.removeKeyboardDismissRecognizer()
        self.unsubscribeToKeyboardNotifications()
        
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    @IBAction func actionLogin(sender: AnyObject) {
        //print("Email  \(outletEmail.text!)  and  passcode \(outletPassword.text!)")
        if outletEmail.text!.isEmpty {
            outletError.text = "Username Empty."
            
            alert_message("Alert", messagem:   "Username Empty - try again",  clickm: "Click")
            
        } else if outletPassword.text!.isEmpty {
            outletError.text = "Password Empty."
            alert_message("Alert", messagem:   "Passcode Empty - try again",  clickm: "Click")
            
        } else {
            self.setUIEnabled(enabled: false)
            /*  Steps for authenitication into the udacity site
            1. Create request token
            2. ask user for permission via api
            3. create a sessionn ID
            */
            //print ("Both a passcode and username")
            outletError.text = "" //clear the error message
            
            UdacityClient.getSessionID(outletEmail as String)
            
            
            
            //UdacityLogin("\(outletEmail.text)","\(outletEmail.text)")
            
            //outletEmail,outletPassword
            
            
            //self.getsessionID()
            
        }
    }
    
    
    
    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            self.outletError.text = ""
            self.setUIEnabled(enabled: true)
            // let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MoviesTabBarController") as! UITabBarController
            // self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    
    func alert_message( alertm: String, messagem:  String, clickm: String)  {
        // manages the alert messages on a separate thread
        dispatch_async(dispatch_get_main_queue(), {
            let alert = UIAlertController(title: alertm, message: messagem, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: clickm, style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    
    
    
    
    
    /*   func getsessionID() {
    
    
    let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
    request.HTTPMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.HTTPBody = "{\"udacity\": {\"username\": \"\(outletEmail.text!)\", \"password\": \"\(outletPassword.text!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
    //print("\(outletEmail.text)","\(outletPassword.text)")
    print("This is the request ")
    print("\(request)")
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithRequest(request) { data, response, error in
    guard(error == nil) else {
    dispatch_async(dispatch_get_main_queue()) {
    self.setUIEnabled(enabled: true)
    self.outletError.text = "Login Failed (Request Token)."
    }
    print("There was an error with your request: \(error)")
    return
    }
    
    /* GUARD: Did we get a successful 2XX response? */
    guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
    dispatch_async(dispatch_get_main_queue()) {
    self.setUIEnabled(enabled: true)
    }
    if let response = response as? NSHTTPURLResponse {
    print("Your request returned an invalid response! Status code: \(response.statusCode)!")
    
    self.alert_message("Alert",
    messagem:   "There is a problem with either your username or passcode ! Status code: \(response.statusCode)!",
    clickm: "Click")
    }
    return
    }
    
    /* GUARD: Was there any data returned? */
    guard let data = data else {
    dispatch_async(dispatch_get_main_queue()) {
    self.setUIEnabled(enabled: true)
    
    }
    print("No data was returned by the request!")
    return
    }
    
    // Parse the Data
    let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
    //print("newData    : \(newData)")
    // print(NSString(data: newData, encoding: NSUTF8StringEncoding)!)
    // print(NSString(data: data, encoding: NSUTF8StringEncoding)!)
    
    
    let parsedResult: AnyObject!
    do {
    
    parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments) as! NSDictionary// converts raw data to a foundation object
    
    // needs to be converted to an NSDictioary (Udacity 2.9)
    
    
    //parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
    // print("getRequestToken\(parsedResult)")
    
    
    // print("Get information from converted JSON Dictionary")
    // print("account ")
    // print(parsedResult["account"]!)
    /*
    Optional({
    key = u31487963;
    registered = 1;
    })
    */
    //print ("")
    //print("session data")
    //print(parsedResult["session"]!)
    /*
    Optional({
    expiration = "2015-11-27T18:26:28.081520Z";
    id = 1475000788Sb52cc09ae89b6d54970c276e6f6fbac0;
    })
    */
    
    //  print("can we get the SESSION ID")
    //  print (parsedResult.valueForKey("session")!) // is a tuple
    /*
    {
    expiration = "2015-11-27T18:26:28.081520Z";
    id = 1475000788Sb52cc09ae89b6d54970c276e6f6fbac0;
    }
    */
    // print("can we get the ID")
    //  print (parsedResult.valueForKey("session")!["id"]!)
    /*
    Optional(1475000788Sb52cc09ae89b6d54970c276e6f6fbac0)
    */
    //let session_ID = parsedResult.valueForKey("session")!["id"]! as! String
    // print(session_ID) // this would give just the id
    
    } catch {
    parsedResult = nil
    dispatch_async(dispatch_get_main_queue()) {
    self.setUIEnabled(enabled: true)
    }
    print("Could not parse the data as JSON: '\(newData)'")
    return
    }
    
    /* GUARD: Did  return an error? */
    guard (parsedResult.objectForKey("status_code") == nil) else {
    dispatch_async(dispatch_get_main_queue()) {
    self.setUIEnabled(enabled: true)
    }
    print("Udacity returned an error. See the status_code and status_message in \(parsedResult)")
    return
    }
    
    /* GUARD: Is the sessionID in parsedResult? */
    guard let sessionID = parsedResult.valueForKey("session")!["id"]! as! String! else {
    dispatch_async(dispatch_get_main_queue()) {
    self.setUIEnabled(enabled: true)
    self.outletError.text = "Login Failed (sessionID)."
    }
    print("Cannot find sessionID in \(parsedResult)")
    return
    }
    
    /* 6. Use the data! */
    print("This is the sessionID   \(sessionID)")
    self.appDelegate.sessionID = sessionID
    }
    
    /* 7. Start the request */
    task.resume()
    
    
    
    //  (NSString(data: data!, encoding: NSUTF8StringEncoding)!) as Dictionary
    
    }
    
    /* example response
    {
    "account":{
    "registered":true,
    "key":"3903878747"
    },
    "session":{
    "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
    "expiration":"2015-05-10T16:48:30.760460Z"
    }
    }
    with hardcoded get:
    
    Optional({
    "account": {
    "registered": true,
    "key": "u31487963"},
    "session": {
    "id": "1474809878S4ebd10b9499a7a6804b0120c50266403",
    "expiration": "2015-11-25T13:24:38.737750Z"}})
    */
    
    
    // step 2. ask user for permision via api
    
    */
    
    
    
    @IBAction func actionSignUp(sender: UIButton) {
    }
    
    
    @IBAction func actionFacebookSignIn(sender: AnyObject) {
    }
    
}

//extention for keyboard functionality
extension LoginViewController {
    
    
    func setUIEnabled(enabled enabled: Bool) {
        outletEmail.enabled = enabled
        outletPassword.enabled = enabled
        outletLogin.enabled = enabled
        outletError.enabled = enabled
        
        if enabled {
            outletLogin.alpha = 1.0
        } else {
            outletLogin.alpha = 0.5
        }
    }
    
    func configureUI() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer?.numberOfTapsRequired = 1
        
    }
    
    
    func addKeyboardDismissRecognizer() {
        self.view.addGestureRecognizer(tapRecognizer!)
    }
    
    func removeKeyboardDismissRecognizer() {
        self.view.removeGestureRecognizer(tapRecognizer!)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification) / 2
            self.view.superview?.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if keyboardAdjusted == true {
            self.view.superview?.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
}












