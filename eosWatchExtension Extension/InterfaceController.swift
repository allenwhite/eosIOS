//
//  InterfaceController.swift
//  eosWatchExtension Extension
//
//  Created by Greg Miller on 11/15/15.
//  Copyright © 2015 ScheduleFour. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController,WCSessionDelegate {

    
    var session: WCSession!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
            
        }
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
       // self.watchTitle.setText(message["title"]! as? String)
    }
    
    
    
}
