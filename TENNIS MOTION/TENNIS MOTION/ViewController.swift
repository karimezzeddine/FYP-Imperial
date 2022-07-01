//
//  ViewController.swift
//  TENNIS MOTION
//
//  Created by Mac on 6/1/22.
//

import UIKit
import CoreML
import os.log
import WatchConnectivity

var dataSample = [[Float]]()
var number_strokes = "0"


class ViewController: UIViewController {
    
    var testText = "hello"
    
    var gmax = [Float]()
    var gmin = [Float]()
    var gmean = [Float]()
    var gstd = [Float]()
    var garea = [Float]()
    
    var accmax = [Float]()
    var accmin = [Float]()
    var accmean = [Float]()
    var accstd = [Float]()
    var accarea = [Float]()
    
    var session2: WCSession?//2
//    var WCM = WatchConnectivityManager()
    var DPM = DataProcessingManager()
    var MLM = MachineLearningManager()
    
    
    @IBOutlet weak var Shot_class: UILabel!
    @IBOutlet weak var Racket_speed: UILabel!
    @IBOutlet weak var Shot_consistency: UILabel!
    @IBOutlet weak var Hit_miss: UILabel!
    @IBOutlet weak var Follow_through: UILabel!
    @IBOutlet weak var num_strokes: UILabel!
    @IBOutlet weak var shot_level: UILabel!
    
    @IBOutlet weak var label_shots: UILabel!
    @IBOutlet weak var label_class: UILabel!
    @IBOutlet weak var label_level: UILabel!
    @IBOutlet weak var label_speed: UILabel!
    @IBOutlet weak var label_cons: UILabel!
    @IBOutlet weak var label_miss: UILabel!
    @IBOutlet weak var label_follow: UILabel!
    
    func configureWatchKitSession() {
        
        
        if WCSession.isSupported() {
            session2 = WCSession.default
            session2?.delegate = self
            session2?.activate()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWatchKitSession()
        
        let N = CGFloat(20)
        
        label_shots.clipsToBounds = true
        label_shots.layer.cornerRadius = N
        
        label_class.clipsToBounds = true
        label_class.layer.cornerRadius = N
        
        label_level.clipsToBounds = true
        label_level.layer.cornerRadius = N
        
        label_speed.clipsToBounds = true
        label_speed.layer.cornerRadius = N
        
        label_cons.clipsToBounds = true
        label_cons.layer.cornerRadius = N
        
        label_miss.clipsToBounds = true
        label_miss.layer.cornerRadius = N
        
        label_follow.clipsToBounds = true
        label_follow.layer.cornerRadius = N
    }
    
    func create_stroke(stroke_color: Int, x: Int, y:Int) {
        
        let shapeLayer = CAShapeLayer()
        let centre = CGPoint(x: x, y: y)
        let circularpath = UIBezierPath(arcCenter: centre, radius: 50, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = circularpath.cgPath
        shapeLayer.lineWidth = 8
        shapeLayer.strokeEnd = 0
        
        
        
        if stroke_color == 1 {
            shapeLayer.strokeColor = UIColor.red.cgColor
        }
        if stroke_color == 2 {
            shapeLayer.strokeColor = UIColor.orange.cgColor
        }
        if stroke_color == 3 {
            shapeLayer.strokeColor = UIColor.yellow.cgColor
        }
        if stroke_color == 4 {
            shapeLayer.strokeColor = UIColor.green.cgColor
        }
        
        view.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        if stroke_color == 1 {
            basicAnimation.toValue = 0.25
        }
        if stroke_color == 2 {
            basicAnimation.toValue = 0.5
        }
        if stroke_color == 3 {
            basicAnimation.toValue = 0.75
        }
        if stroke_color == 4 {
            basicAnimation.toValue = 1
        }
        
        basicAnimation.duration = 1
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "Hello")
        
    }
    
    func reset_interface() {
        
        num_strokes.text = "0"
        
        Shot_class.text = "N/A"
        
        Racket_speed.text = "N/A"
        
        
        Shot_consistency.text = "N/A"
        
        Hit_miss.text = "N/A"

        Follow_through.text = "N/A"
        
        SummaryStats.rally_speed = [Float]()
        SummaryStats.rally_consistency = [Float]()
        SummaryStats.rally_hit_miss = 0
        SummaryStats.rally_follow_through = 0
    }

    
    func runDataAnalysis(Sample: [[Float]]) {
        let dataArray = Sample
        print("hi")
        print(dataArray)
        let num_of_shots = number_strokes
        num_strokes.text = num_of_shots
        
        if dataArray.count > 1 {
            var gyro_X = [Float](repeating: 0, count: 120)
            var gyro_Y = [Float](repeating: 0, count: 120)
            var gyro_Z = [Float](repeating: 0, count: 120)
            
            var acc_X = [Float](repeating: 0, count: 120)
            var acc_Y = [Float](repeating: 0, count: 120)
            var acc_Z = [Float](repeating: 0, count: 120)
            
            var grav_X = [Float](repeating: 0, count: 120)
            var grav_Y = [Float](repeating: 0, count: 120)
            var grav_Z = [Float](repeating: 0, count: 120)
            
            //1. separate the data array into the 3 axes accelerometer/gyroscope
            for i in (0...119) {
                gyro_X[i] = dataArray[i][0]
                gyro_Y[i] = dataArray[i][1]
                gyro_Z[i] = dataArray[i][2]
                
                acc_X[i] = dataArray[i][3]
                acc_Y[i] = dataArray[i][4]
                acc_Z[i] = dataArray[i][5]
                
                grav_X[i] = dataArray[i][6]
                grav_Y[i] = dataArray[i][7]
                grav_Z[i] = dataArray[i][8]
            }
                print(gyro_Z)
            
            //2. Extract the features for every column (mean, std, max, min, aoc)
            //The order followed is (to conform with the training data): [amaxX,amaxY,amaxZ,aminX,aminY,aminZ,ameanX,ameanY,ameanZ,astdX,astdY,astdZ,aaocX,aaocY,aaocZ] and same for gyroscope
            
            var list_features = [Float](repeating: 0, count: 45)
            let length = Float(acc_X.count)
            
            //ACCELEROMETER VALUES
            
            list_features[0] = acc_X.max()!
            list_features[1] = acc_Y.max()!
            list_features[2] = acc_Z.max()!
            
            list_features[3] = acc_X.min()!
            list_features[4] = acc_Y.min()!
            list_features[5] = acc_Z.min()!
            
            list_features[6] = acc_X.reduce(0, {$0 + $1}) / length
            list_features[7] = acc_Y.reduce(0, {$0 + $1}) / length
            list_features[8] = acc_Z.reduce(0, {$0 + $1}) / length
            
            list_features[9] = DPM.standardDeviation(arr: acc_X)
            list_features[10] = DPM.standardDeviation(arr: acc_Y)
            list_features[11] = DPM.standardDeviation(arr: acc_Z)
            
            list_features[12] = DPM.traps(arr: acc_X)
            list_features[13] = DPM.traps(arr: acc_Y)
            list_features[14] = DPM.traps(arr: acc_Z)
            
            //GYROSCOPE VALUES
            list_features[15] = gyro_X.max()!
            list_features[16] = gyro_Y.max()!
            list_features[17] = gyro_Z.max()!
            
            list_features[18] = gyro_X.min()!
            list_features[19] = gyro_Y.min()!
            list_features[20] = gyro_Z.min()!
            
            list_features[21] = (gyro_X.reduce(0, {$0 + $1}) / length)
            list_features[22] = (gyro_Y.reduce(0, {$0 + $1}) / length)
            list_features[23] = (gyro_Z.reduce(0, {$0 + $1}) / length)
            
            list_features[24] = (DPM.standardDeviation(arr: gyro_X))
            list_features[25] = (DPM.standardDeviation(arr: gyro_Y))
            list_features[26] = (DPM.standardDeviation(arr: gyro_Z))
            
            list_features[27] = (DPM.traps(arr: gyro_X))
            list_features[28] = (DPM.traps(arr: gyro_Y))
            list_features[29] = (DPM.traps(arr: gyro_Z))
            
            list_features[30] = (grav_X.max()!)
            list_features[31] = (grav_Y.max()!)
            list_features[32] = (grav_Z.max()!)
            
            list_features[33] = (grav_X.min()!)
            list_features[34] = (grav_Y.min()!)
            list_features[35] = (grav_Z.min()!)
            
            list_features[36] = (grav_X.reduce(0, {$0 + $1}) / length)
            list_features[37] = (grav_Y.reduce(0, {$0 + $1}) / length)
            list_features[38] = (grav_Z.reduce(0, {$0 + $1}) / length)
            
            list_features[39] = (DPM.standardDeviation(arr: grav_X))
            list_features[40] = (DPM.standardDeviation(arr: grav_Y))
            list_features[41] = (DPM.standardDeviation(arr: grav_Z))
            
            list_features[42] = (DPM.traps(arr: grav_X))
            list_features[43] = (DPM.traps(arr: grav_Y))
            list_features[44] = (DPM.traps(arr: grav_Z))
            
            print("list of features input: \(list_features)")
            let config = MLModelConfiguration()
//            let classifier_stroke = try! Shot_classifier_grav(configuration: config)
            
            let classifier_stroke = try! Shot_classifier_grav_SVM_copy(configuration: config)
//            let classifier_stroke = try! CART_classifier(configuration: config)
        
            let output_label = try! classifier_stroke.prediction(aXmax: Double(list_features[0]), aYmax: Double(list_features[1]), aZmax: Double(list_features[2]), aXmin: Double(list_features[3]), aYmin: Double(list_features[4]), aZmin: Double(list_features[5]), aXmean: Double(list_features[6]), aYmean: Double(list_features[7]), aZmean: Double(list_features[8]), aXstd: Double(list_features[9]), aYstd: Double(list_features[10]), aZstd: Double(list_features[11]), aXArea: Double(list_features[12]), aYArea: Double(list_features[13]), aZArea: Double(list_features[14]), gXmax: Double(list_features[15]), gYmax: Double(list_features[16]), gZmax: Double(list_features[17]), gXmin: Double(list_features[18]), gYmin: Double(list_features[19]), gZmin: Double(list_features[20]), gXmean: Double(list_features[21]), gYmean: Double(list_features[22]), gZmean: Double(list_features[23]), gXstd: Double(list_features[24]), gYstd: Double(list_features[25]), gZstd: Double(list_features[26]), gXArea: Double(list_features[27]), gYArea: Double(list_features[28]), gZArea: Double(list_features[29]), gravXmax: Double(list_features[30]), gravYmax: Double(list_features[31]), gravZmax: Double(list_features[32]), gravXmin: Double(list_features[33]), gravYmin: Double(list_features[34]), gravZmin: Double(list_features[35]), gravXmean: Double(list_features[36]), gravYmean: Double(list_features[37]), gravZmean: Double(list_features[38]), gravXstd: Double(list_features[39]), gravYstd: Double(list_features[40]), gravZstd: Double(list_features[41]), gravXArea: Double(list_features[42]), gravYArea: Double(list_features[43]), gravZArea: Double(list_features[44]))

            
            Shot_class.text = DPM.mapping(label: Int(output_label.Class_))
            SummaryStats.sequence_shots.append(DPM.mapping(label: Int(output_label.Class_)))
            
            //PLAYER-LEVEL CLASSIFICATION FOR EACH STROKE TYPE
            let level_label = MLM.level_classification(list_features: list_features, output_label: Int(output_label.Class_))
            print("Level: \(level_label)")
            shot_level.text = String(level_label)
            if (level_label == "Novice") {
                shot_level.textColor = UIColor.red
            }
            if (level_label == "Expert") {
                shot_level.textColor = UIColor.green
            }
            
            //1. RACKET SPEED
            let racket_speed = DPM.RacketSpeed(arr1: gyro_Y, arr2: gyro_Z)
//            self.create_stroke(stroke_color: Int(DPM.RacketSpeed(arr1: gyro_Y, arr2: gyro_Z)[1]),x: 315, y: 390)
            if racket_speed < 20 {
                Racket_speed.textColor = UIColor.red
            }
            if (racket_speed < 30) && (racket_speed >= 20) {
                Racket_speed.textColor = UIColor.orange
            }
            if (racket_speed < 40) && (racket_speed >= 30) {
                Racket_speed.textColor = UIColor.yellow
            }
            if (racket_speed >= 40) {
                Racket_speed.textColor = UIColor.green
            }
            Racket_speed.text = String(Int(racket_speed))
            print("racket speed: \(Int(racket_speed))")
            SummaryStats.rally_speed.append(racket_speed)
            var average_racket_speed = SummaryStats.rally_speed.reduce(0, +) / Float(SummaryStats.rally_speed.count)
            
            //2. SHOT CONSISTENCY
            let consistency = DPM.ShotConsistency(arr1 : gyro_X,arr2 : gyro_Y,arr3 :gyro_Z,arr4 :acc_X ,arr5 : acc_Y,arr6 : acc_Z)
//            self.create_stroke(stroke_color: Int(DPM.ShotConsistency(arr1 : gyro_X,arr2 : gyro_Y,arr3 :gyro_Z,arr4 :acc_X ,arr5 : acc_Y,arr6 : acc_Z)[1]),x: 315, y: 510)
            Shot_consistency.text = String(round(consistency * 100) / 100.0)
            if consistency < 0.4 {
                Shot_consistency.textColor = UIColor.green
            }
            if (consistency < 0.7) && (consistency >= 0.4) {
                Shot_consistency.textColor = UIColor.yellow
            }
            if (consistency < 1) && (consistency >= 0.7) {
                Shot_consistency.textColor = UIColor.orange
            }
            if (consistency >= 1) {
                Shot_consistency.textColor = UIColor.red
            }
            SummaryStats.rally_consistency.append(consistency)
            var average_shot_consistency = SummaryStats.rally_consistency.reduce(0, +) / Float(SummaryStats.rally_consistency.count)
            
                
            //3. HIT/MISS
            let hit_miss = DPM.hit_miss(arr1: &acc_Z, output_classification: Int(output_label.Class_))
            Hit_miss.text = hit_miss
            if (hit_miss == "Miss") {
                Hit_miss.textColor = UIColor.red
            }
            if (hit_miss == "Hit") {
                Hit_miss.textColor = UIColor.green
                SummaryStats.rally_hit_miss += 1
            }
            if (hit_miss == "N/A") {
                Hit_miss.textColor = UIColor.white
            }
            
            var num_hits = SummaryStats.rally_hit_miss
            var num_misses = Int(length) - SummaryStats.rally_hit_miss

            
            //4. FOLLOW-THROUGH
            let follow_through = DPM.follow_through(arr: gyro_Z, output_classification: Int(output_label.Class_))
            Follow_through.text = follow_through
            if (follow_through == "Inconsistent") {
                Follow_through.textColor = UIColor.red
            }
            if (follow_through == "Consistent") {
                Follow_through.textColor = UIColor.green
                SummaryStats.rally_follow_through += 1
            }
            if (follow_through == "N/A") {
                Follow_through.textColor = UIColor.white
            }
            var num_follow_through = SummaryStats.rally_follow_through
            var num_no_follow_through = Int(length) - SummaryStats.rally_follow_through
            
            
            print("acc_X: \(acc_X)")
            print("acc_Y: \(acc_Y)")
            print("acc_Z: \(acc_Z)")
            print("gyro_X: \(gyro_X)")
            print("gyro_Y: \(gyro_Y)")
            print("gyro_Z: \(gyro_Z)")
            print("list of features: \(list_features)")
            print("average racket speed: \(average_racket_speed)")
            
        }
        
    }
}

// WCSession delegate functions
extension ViewController: WCSessionDelegate {
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        print("received message: \(message)")
        DispatchQueue.main.async { //6
            if let value = message["watch"] as? String {
//                print(value)
                number_strokes = value
                let data: [String: Any] = ["phone": "\(String(number_strokes))" as Any]
                
                session.sendMessage(data, replyHandler: nil, errorHandler: nil)
                }

            if let value = message["d"] as? [[Float]] {

            //float value
//          let FloatValue = value.floatValue
                dataSample = value
                print("assigned, running analysis")
                self.runDataAnalysis(Sample: dataSample)
            }


            if let value = message["watchStart"] as? String {
                self.reset_interface() //Reset all content of the viewcontroller      
            }
            
            
        }
    }
}


struct SummaryStats {
    static var rally_speed = [Float]()
    static var rally_consistency = [Float]()
    static var rally_hit_miss = 0
    static var rally_follow_through = 0
    static var sequence_shots = [String]()
}

struct VC_Communication {
    static var start = true
}






