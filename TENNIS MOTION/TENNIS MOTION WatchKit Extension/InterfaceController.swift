//
//  InterfaceController.swift
//  TENNIS MOTION WatchKit Extension
//
//  Created by Mac on 6/1/22.
//

import WatchKit
import Foundation
import WatchConnectivity



class InterfaceController: WKInterfaceController {

    
    var session1 = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        session1.delegate = self
        session1.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    var isRunning = false
    var WOM = WorkoutManager()
    var DMM = DeviceMotionManager()
    
    
    @IBOutlet weak var Shot_count: WKInterfaceLabel!
    @IBOutlet weak var Announcement: WKInterfaceLabel!
    
    @IBAction func RecordSwitch(_ value: Bool) {
        isRunning = value
        if value {
            self.Shot_count.setText(String(0))
            let data: [String: Any] = ["watchStart": "S" as Any]
            session1.sendMessage(data, replyHandler: nil, errorHandler: nil)
            
            self.Announcement.setText("Started Recording...")
            WOM.startWorkout()
            DMM.startUpdates()
            
        
                
            }
        //else create a csv file when turned off
        else {
            self.Announcement.setText("Stopped Recording!")
            DMM.stopUpdates()
            WOM.endWorkout()
            let data: [String: Any] = ["watchFinish": "F" as Any]
            session1.sendMessage(data, replyHandler: nil, errorHandler: nil)
        }
    }
    
    

}

// WCSession delegate functions
extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("received message: \(message)")
        DispatchQueue.main.async { //6
            if let value = message["phone"] as? String {
                self.Shot_count.setText(String(value))
                }

        }
    }
}
