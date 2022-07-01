//
//  ViewController2.swift
//  TENNIS MOTION
//
//  Created by Mac on 6/4/22.
//

import Foundation
import UIKit
import WatchConnectivity


class ViewController2: UIViewController {
    
//    var lineChart = LineChartView()
    @IBOutlet weak var Av_speed: UILabel!
    @IBOutlet weak var Av_consistency: UILabel!
    @IBOutlet weak var Num_hits: UILabel!
    @IBOutlet weak var Num_misses: UILabel!
    @IBOutlet weak var Num_consistent_follow_through: UILabel!
    @IBOutlet weak var Num_inconsistent_follow_through: UILabel!
    
    
    @IBOutlet weak var label_hits: UILabel!
    @IBOutlet weak var label_misses: UILabel!
    @IBOutlet weak var label_consistent: UILabel!
    @IBOutlet weak var label_inconsistent: UILabel!
    @IBOutlet weak var label_averages: UILabel!
    
    var session3: WCSession?
    
    func configureWatchKitSession() {
        
        
        if WCSession.isSupported() {
            session3 = WCSession.default
            session3?.delegate = self
            session3?.activate()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWatchKitSession()
        // Do any additional setup after loading the view.
        print("done")
        
        let N = CGFloat(20)
        
        label_hits.clipsToBounds = true
        label_hits.layer.cornerRadius = N
        
        label_misses.clipsToBounds = true
        label_misses.layer.cornerRadius = N
        
        label_consistent.clipsToBounds = true
        label_consistent.layer.cornerRadius = N
        
        label_inconsistent.clipsToBounds = true
        label_inconsistent.layer.cornerRadius = N
        
        label_averages.clipsToBounds = true
        label_averages.layer.cornerRadius = N
        
        
        
    }
    
    func reset_interface2() {
        Av_speed.text = "N/A"
        Av_consistency.text = "N/A"
        Num_hits.text = "N/A"
        Num_misses.text = "N/A"
        Num_consistent_follow_through.text = "N/A"
        Num_inconsistent_follow_through.text = "N/A"
    }
    
    
    func Summary(rally_speed: [Float],rally_consistency: [Float],
                 rally_hit_miss: Int,
                 rally_follow_through: Int, sequence_shots: [String]) {
        
        let length = Float(rally_speed.count)
        
        let average_racket_speed = SummaryStats.rally_speed.reduce(0, {$0 + $1}) / length
        //INPUT HERE TO ADD LABEL FOR RALLY RACKET SPEED AVERAGE
        Av_speed.text = String(average_racket_speed)
        
        let average_shot_consistency = rally_consistency.reduce(0, {$0 + $1}) / length
        //INPUT HERE TO ADD LABEL FOR RALLY CONSISTENCY AVERAGE
        Av_consistency.text = String(average_shot_consistency)
        
        let num_hits = rally_hit_miss
        let num_misses = Int(length) - rally_hit_miss
        //INPUT HERE TO ADD LABEL FOR RALLY NUMBER OF HITS AND MISSES SEPARATELY
        Num_hits.text = String(num_hits)
        Num_misses.text = String(num_misses)
        
        let num_follow_through = rally_follow_through
        let num_no_follow_through = Int(length) - rally_follow_through
        //INPUT HERE TO ADD LABEL FOR RALLY NUMBER OF CONSISTENT AND INCONSISTENT FOLLOW-THROUGHS SEPARATELY
        Num_consistent_follow_through.text = String(num_follow_through)
        Num_inconsistent_follow_through.text = String(num_no_follow_through)
        
        
    }
}


// WCSession delegate functions
extension ViewController2: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("received message: \(message)")
        DispatchQueue.main.async { //6

            if let value = message["watchStart"] as? String {
                self.reset_interface2()
            }
            
            if let value = message["watchFinish"] as? String {
                print("rally racket speed: \(SummaryStats.rally_speed)")
                self.Summary(rally_speed: SummaryStats.rally_speed,rally_consistency: SummaryStats.rally_consistency,
                             rally_hit_miss: SummaryStats.rally_hit_miss,
                             rally_follow_through: SummaryStats.rally_follow_through, sequence_shots: SummaryStats.sequence_shots)
            }
        }
    }
}
