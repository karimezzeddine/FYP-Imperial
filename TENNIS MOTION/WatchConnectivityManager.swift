//
//  WatchConnectivityManager.swift
//  TENNIS MOTION WatchKit Extension
//
//  Created by Mac on 6/1/22.
//

//import Foundation
//import WatchConnectivity
//
//class WatchConnectivityManager : NSObject,  WCSessionDelegate, ObservableObject
//{
//    var session: WCSession
//
//    init(session: WCSession = .default)
//    {
//        self.session = session
//        super.init()
//        self.session.delegate = self
//        self.session.activate()
//    }
//
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
//    {
//        print(activationState.rawValue)
//        print(session.activationState.rawValue)
//        print(self.sessionActive)
//    }
//
//
//
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void)
//    {
//        print("received message: \(message)")
//        DispatchQueue.main.async
//        {
//            #if os(iOS)
//            if let value = message["watch"] as? String {
//                print(value)
//                num_shots.number_strokes = value
//                }
//
//            if let value = message["d"] as? [[Float]] {
//
//            //float value
////          let FloatValue = value.floatValue
//                dataArray.dataSample = value
//                print(dataArray.dataSample)
//            }
//
//
//            if let value = message["watchStart"] as? String {
//                //here try to erase all content of the viewcontroller
//
//            }
//
//            #endif
//
//        }
//    }
//
//    @Published var sessionActive = false
//
//    func sendMessage(message: Any)
//    {
//
//        session.sendMessage(["message" : message], replyHandler: nil) { (error) in
//            print(error.localizedDescription) }
//    }
//
//    #if os(iOS)
//    func sessionDidBecomeInactive(_ Session_Struct: WCSession) {
//        print("Init")
//    }
//
//    func sessionDidDeactivate(_ Session_Struct: WCSession) {
//        print("Dead")
//    }
//    #endif
//
//
//}
//
//
//extension String {
//    func floatValue() -> Float? {
//        return Float(self)
//    }
//}


//struct dataArray {
//    static var dataSample = [[Float]]()
//}
//
//struct num_shots {
//    static var number_strokes = "0"
//}

