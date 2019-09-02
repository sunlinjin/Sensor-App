//
//  CoreMotionAPI.swift
//  Sensor-App
//
//  Created by Volker Schmitt on 02.09.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//

// MARK: - Import
import Foundation
import CoreMotion


// MARK: - Class Definition
class CoreMotionAPI {
    
    // MARK: - Initialize Classes
    private var motionManager : CMMotionManager
    private var magnetManager : CMMagnetometerData
    private var altimeterManager : CMAltimeter
    private var attitude : CMAttitude
    
    
    // MARK: - Singleton pattern
    static var shared : CoreMotionAPI = CoreMotionAPI()
    private init() {
        motionManager = CMMotionManager()
        magnetManager = CMMagnetometerData()
        altimeterManager = CMAltimeter()
        attitude = CMAttitude()
    }
    
    
    // MARK: - Variables / Constants
    var sensorUpdateInterval : Double = 1.0
    var motionModelArray = [MotionModel]()
    var altitudeModelArray = [AltitudeModel]()
    
    
    // Closure to push MotionModel to Viewcontroller
    var motionCompletionHandler: (([MotionModel]) -> Void)?
    var altitudeCompletionHandler: (([AltitudeModel]) -> Void)?
    
    
    // MARK: - Methods
    func motionStartMethod() {
        self.motionManager.startDeviceMotionUpdates(using: .xTrueNorthZVertical, to: .main) { (data, error) in
            guard let data = data, error == nil else {
                return
            }
            self.motionManager.deviceMotionUpdateInterval = self.sensorUpdateInterval
            
            
            // Acceleration
            let accelerationX = data.userAcceleration.x
            let accelerationY = data.userAcceleration.y
            let accelerationZ = data.userAcceleration.z
            
            print("Acceleration X: \(accelerationX)")
            print("Acceleration Y: \(accelerationY)")
            print("Acceleration Z: \(accelerationZ)")
            
            
            // Gravity
            let gravityX = data.gravity.x
            let gravityY = data.gravity.y
            let gravityZ = data.gravity.z
            
            print("Gravity X: \(gravityX)")
            print("Gravity Y: \(gravityY)")
            print("Gravity Z: \(gravityZ)")
            
            
            // Gyrometer
            let gyroX = data.rotationRate.x
            let gyroY = data.rotationRate.y
            let gyroZ = data.rotationRate.z
            
            print("Gyrometer X: \(gyroX)")
            print("Gyrometer Y: \(gyroZ)")
            print("Gyrometer Z: \(gyroX)")
            
            
            // Magnetometer
            let magnetometerCalibration = Int(data.magneticField.accuracy.rawValue)
            let magnetometerX = data.magneticField.field.x
            let magnetometerY = data.magneticField.field.y
            let magnetometerZ = data.magneticField.field.z
            
            print("Magnetometer Calib.: \(magnetometerCalibration)")
            print("Magnetometer X: \(magnetometerX)")
            print("Magnetometer Y: \(magnetometerY)")
            print("Magnetometer Z: \(magnetometerZ)")
            
            
            // Attitude
            let attitudeRoll = data.attitude.roll
            let attitudePitch = data.attitude.pitch
            let attitudeYaw = data.attitude.yaw
            let attitudeHeading = data.heading
            
            print("Roll: \(attitudeRoll)")
            print("Pitch: \(attitudePitch)")
            print("Yaw: \(attitudeYaw)")
            print("Heading: \(attitudeHeading) °")
            
            
            // Insert Motion into Array
            self.motionModelArray.insert(MotionModel(
                counter: self.motionModelArray.count + 1,
                timestamp: SettingsAPI.shared.getTimestamp(),
                accelerationXAxis: accelerationX,
                accelerationYAxis: accelerationY,
                accelerationZAxis: accelerationZ,
                gravityXAxis: gravityX,
                gravityYAxis: gravityY,
                gravityZAxis: gravityZ,
                gyroXAxis: gyroX,
                gyroYAxis: gyroY,
                gyroZAxis: gyroZ,
                magnetometerCalibration: magnetometerCalibration,
                magnetometerXAxis: magnetometerX,
                magnetometerYAxis: magnetometerY,
                magnetometerZAxis: magnetometerZ,
                attitudeRoll: attitudeRoll,
                attitudePitch: attitudePitch,
                attitudeYaw: attitudeYaw,
                attitudeHeading: attitudeHeading
            ), at: 0)
            
            
            // Push Model to ViewController
            self.motionCompletionHandler?(self.motionModelArray)
            
            
            // Altimeter
            self.altimeterManager.startRelativeAltitudeUpdates(to: .main) { (altimeter, error) in
                guard let altimeter = altimeter, error == nil else {
                    return
                }
                let pressureValue = Double(truncating: altimeter.pressure) // pressure in kPa
                let relativeAltitudeValue = Double(truncating: altimeter.relativeAltitude) // change in m
                
                print("Pressure: \(pressureValue / 100)")
                print("Relative Altitude change: \(relativeAltitudeValue)")
                
                let altitude = CalculationAPI.shared.convertAltitudeData(pressure: pressureValue, height: relativeAltitudeValue)
                
                // Insert Motion into Array
                self.altitudeModelArray.insert(AltitudeModel(
                    counter: self.altitudeModelArray.count + 1,
                    timestamp: SettingsAPI.shared.getTimestamp(),
                    pressureValue: altitude.convertedPressure,
                    relativeAltitudeValue: altitude.convertedHeight
                ), at: 0)
                
                // Push Model to ViewController
                self.altitudeCompletionHandler?(self.altitudeModelArray)
            }
        }
    }
    
    
    // Stop Motion Updates
    func motionStopMethod() {
        motionManager.stopDeviceMotionUpdates()
        altimeterManager.stopRelativeAltitudeUpdates()
    }
    
    
    // Clear Arrays
    func clearMotionArray(completion: @escaping () -> Void) {
        self.motionModelArray.removeAll()
        self.altitudeModelArray.removeAll()
        completion()
    }
    
}