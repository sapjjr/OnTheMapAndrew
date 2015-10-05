//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by andrew on 23/09/2015.
//  Copyright © 2015 Firekite. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

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
    
 //   let textDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Get the app delegate */
      // appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
        self.configureUI()
        
        
        
       // self.outletEmail.delegate = textDelegate
      //  self.outletPassword.delegate = textDelegate

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
            outletError.text = "" //clear the error message
            UdacityClient.sharedInstance().getSessionID(outletEmail.text!, outletPassword: outletPassword.text!, completionHandler: {( success, errorString) in
                if success {
                    print("\(self.outletEmail.text!)")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.completeLogin()
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.alert_message("Alert", messagem:   "\(errorString!)",  clickm: "Click")
                        //self.displayError(errorString)
                        self.setUIEnabled(enabled: true)
                    })
                }
            })
        }}
    
    
    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            self.outletError.text = ""  // clears text
            self.outletEmail.text = ""
            self.outletPassword.text = ""
            
            self.setUIEnabled(enabled: true)
           let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapTabBarController") as! UITabBarController
           self.presentViewController(controller, animated: true, completion: nil)
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
    
    
    
    @IBAction func actionSignUp(sender: UIButton) {
        //opens a web browser at the UDacity signuo area - cool!
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.google.com/url?q=https://www.udacity.com/account/auth%23!/signin&sa=D&usg=AFQjCNHOjlXo3QS15TqT0Bp_TKoR9Dvypw")!)
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











