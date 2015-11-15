//
//  loginView.swift
//  EOS
//
//  Created by Greg Miller on 11/15/15.
//  Copyright © 2015 ScheduleFour. All rights reserved.
//


import UIKit
import ResearchKit
import WatchConnectivity



class loginView: UIViewController, ORKTaskViewControllerDelegate, WCSessionDelegate {
    
    var session: WCSession!
    
   /* @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
*/
    
    @IBAction func surveyTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    var backgroundImageView = UIImageView(image: UIImage(named: "field_image_logo_overlay.png"))
    var loginButtonImage = UIImage(named: "login_button")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading page")
        
        
        backgroundImageView.frame = self.view.frame
        backgroundImageView.clipsToBounds = true
        backgroundImageView.contentMode = .ScaleAspectFill
        self.view.addSubview(backgroundImageView)
        self.view.sendSubviewToBack(backgroundImageView)
        
        
        
        if (WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   /*
    session.sendMessage(["title" : titleLabel.text!], replyHandler: nil, errorHandler: nil)
*/
    
}

extension loginView {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        //Handle results with taskViewController.result
       taskViewController.dismissViewControllerAnimated(true, completion: nil)
        print("endign consent task")
        //loginView.performSegueWithIdentifier()
        
       // self.performSegueWithIdentifier("loginToGraphSegue", sender: self)
        
    }
    
}
