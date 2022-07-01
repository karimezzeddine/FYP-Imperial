//
//  WorkoutManager.swift
//  TENNIS MOTION WatchKit Extension
//
//  Created by Mac on 6/1/22.
//

import Foundation
import HealthKit
import Combine
import CoreMotion
import WatchConnectivity

class WorkoutManager: NSObject, ObservableObject {
    
    
    var DMM = DeviceMotionManager()
    
    /// - Tag: DeclareSessionBuilder
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession!
//    let session = WCSession.default
    var builder: HKLiveWorkoutBuilder!
    var manager = CMMotionManager()
    var running = false
    
    var start: Date = Date()
    // Provide the workout configuration.
    func workoutConfiguration() -> HKWorkoutConfiguration {
        /// - Tag: WorkoutConfiguration
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .tennis
        configuration.locationType = .outdoor
        
        return configuration
    }
    
    // Start the workout.
    func startWorkout() {
        // Start the timer.
        self.running = true
        let sampleType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: self.workoutConfiguration())
            builder = session.associatedWorkoutBuilder()
        } catch {
            // Handle any exceptions.
            return
        }
        
        // Setup session and builder.
        session.delegate = self
        builder.delegate = self
        
        // Set the workout builder's data source.
        /// - Tag: SetDataSource
        builder.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                     workoutConfiguration: workoutConfiguration())
        
        
        healthStore.enableBackgroundDelivery(for: sampleType!, frequency: .immediate, withCompletion: {(succeeded: Bool, error: Error!) in
                        if succeeded {
                            print("Enabled background delivery")
                        }
                        else {
                            if let theError = error {
                                print("Error = \(theError)")
                            }
                        }
                    } as (Bool, Error?) -> Void)
        
        session.startActivity(with: Date())
//        let data: [String: Any] = ["watchStart": "S" as Any]
//        DMM.session.sendMessage(data, replyHandler: nil, errorHandler: nil)
//        DMM.startUpdates()
    }
    
    
    func endWorkout() {
        // End the workout session.
//        DMM.stopUpdates()
        session.end()
        
    }
    
    func requestAuthorization() {
        // Requesting authorization.
        /// - Tag: RequestAuthorization
        // The quantity type to write to the health store.
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        // The quantity types to read from the health store.
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        ]
        
        // Request authorization for those quantity types.
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            // Handle error.
        }
    }
}

extension WorkoutManager: WCSessionDelegate{
func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
}
}

// MARK: - HKWorkoutSessionDelegate
extension WorkoutManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, date: Date) {
        // Wait for the session to transition states before ending the builder.
        /// - Tag: SaveWorkout
        if toState == .ended {
            print("The workout has now ended.")
            builder.endCollection(withEnd: Date()) { (success, error) in
                self.builder.finishWorkout { (workout, error) in
                    // Optionally display a workout summary to the user.
                }
            }
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
}


extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return // Nothing to do.
            }
            
            /// - Tag: GetStatistics
            //            _ = workoutBuilder.statistics(for: quantityType)
            
        }
    }
}
