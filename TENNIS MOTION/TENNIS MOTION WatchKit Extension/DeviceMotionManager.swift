//
//  DeviceMotionManager.swift
//  TENNIS MOTION WatchKit Extension
//
//  Created by Mac on 6/1/22.
//

import WatchKit
import Foundation
import CoreMotion
import WatchConnectivity
import HealthKit
import os.log


//let WCM = WatchConnectivityManager()
//let INC = InterfaceController()

class DeviceMotionManager: NSObject, ObservableObject{

    
    let session = WCSession.default
    var manager = CMMotionManager()
    var x_gyro = [Float]()
    var y_gyro = [Float]()
    var z_gyro = [Float]()
    var x_acc = [Float]()
    var y_acc = [Float]()
    var z_acc = [Float]()
    var x_grav = [Float]()
    var y_grav = [Float]()
    var z_grav = [Float]()
    var i = 0
    var shot_counter = 0
    var i_detection = 0
    let acc_threshold = 3
    let gyro_threshold = 2
    var detect_shot = false
    
    
    func startUpdates() {
        shot_counter = 0
//        self.Shot_count.setText("0")
        
        if !manager.isDeviceMotionAvailable {
            print("Device Motion is not available.")
            return
        }
        os_log("Start Updates")
        manager.deviceMotionUpdateInterval = 1/80
        manager.startDeviceMotionUpdates(using: .xArbitraryZVertical, to: OperationQueue.current!) { (deviceMotion: CMDeviceMotion?, error: Error?) in
        if error != nil {
            print("Encountered error: \(error!)")
        }
        if deviceMotion != nil {
        self.myDeviceMotion(deviceMotion!)
        }
        }
    }
    func myDeviceMotion(_ deviceMotion: CMDeviceMotion){

        print("Start DeviceMotion")
        self.x_acc.append(Float(deviceMotion.userAcceleration.x))
        self.y_acc.append(Float(deviceMotion.userAcceleration.y))
        self.z_acc.append(Float(deviceMotion.userAcceleration.z))
        self.x_gyro.append(Float(deviceMotion.rotationRate.x))
        self.y_gyro.append(Float(deviceMotion.rotationRate.y))
        self.z_gyro.append(Float(deviceMotion.rotationRate.z))
        self.x_grav.append(Float(deviceMotion.gravity.x))
        self.y_grav.append(Float(deviceMotion.gravity.y))
        self.z_grav.append(Float(deviceMotion.gravity.z))
        
        let magnitude_acc_x = Float(pow(self.x_acc[self.i],2))
        let magnitude_acc_y = Float(pow(self.y_acc[self.i],2))
        let magnitude_acc_z = Float(pow(self.z_acc[self.i],2))

        let magnitude_acceleration = Float(sqrt(magnitude_acc_x+magnitude_acc_y+magnitude_acc_z))
        
        self.i += 1
        print(self.i)
        
        if (magnitude_acceleration > Float(self.acc_threshold)) && (self.detect_shot == false) && (abs(x_gyro[i-1]) > Float(self.gyro_threshold)) {
            
            IK_shot_count.increment_count = true
            self.detect_shot = true
            self.i_detection = self.i
            self.shot_counter += 1
//            self.Shot_count.setText(String(self.shot_counter))
            print(self.i_detection)
            self.x_acc.append(Float(deviceMotion.userAcceleration.x))
            self.y_acc.append(Float(deviceMotion.userAcceleration.y))
            self.z_acc.append(Float(deviceMotion.userAcceleration.z))
            self.x_gyro.append(Float(deviceMotion.rotationRate.x))
            self.y_gyro.append(Float(deviceMotion.rotationRate.y))
            self.z_gyro.append(Float(deviceMotion.rotationRate.z))
            self.x_grav.append(Float(deviceMotion.gravity.x))
            self.y_grav.append(Float(deviceMotion.gravity.y))
            self.z_grav.append(Float(deviceMotion.gravity.z))

            
            self.i += 1
        }

        if (self.detect_shot == true) && (self.i >= (self.i_detection)+60){
            self.detect_shot = false
        

            let data: [String: Any] = ["watch": "\(String(self.shot_counter))" as Any]
            
            session.sendMessage(data, replyHandler: nil, errorHandler: nil)
                
            var ArrayOfSampleData = [[Float]]()
            print(self.i_detection)
            print(self.i)
            print(self.x_grav)

            for i in ((self.i_detection)-60)...((self.i_detection)+59) {

                ArrayOfSampleData.append([self.x_gyro[i],self.y_gyro[i],self.z_gyro[i],self.x_acc[i],self.y_acc[i],self.z_acc[i],self.x_grav[i],self.y_grav[i],self.z_grav[i]])
                
            }
        
        self.detect_shot = false
//        self.i = 0
        self.i_detection = 0
        IK_shot_count.increment_count = false
        
        
        print(ArrayOfSampleData)

        print(ArrayOfSampleData.debugDescription)

        session.sendMessage(["d":ArrayOfSampleData as [[Float]]], replyHandler: nil)
        print("Data sent")
        print("n\n\n\n\n\n\n\n\n\n\(data)\n\n\n\n\n\n\n\n\n")
        }
    }
    
    func stopUpdates() {
        os_log("Stop Updates")
        manager.stopDeviceMotionUpdates()
    }
}

extension DeviceMotionManager: WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
}

struct IK_shot_count {
    static var increment_count = false
}
