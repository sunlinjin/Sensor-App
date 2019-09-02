//
//  GyroscopeViewController.swift
//  Sensor-App
//
//  Created by Volker Schmitt on 25.05.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//

// MARK: - Import
import UIKit


// MARK: - TableViewCell Class
class GyroTableViewCell: UITableViewCell {
    @IBOutlet weak var gyroTableViewCounter: UILabel!
    @IBOutlet weak var gyroTableViewXAxis: UILabel!
    @IBOutlet weak var gyroTableViewYAxis: UILabel!
    @IBOutlet weak var gyroTableviewZAxis: UILabel!
}


// MARK: - Class Definition
class GyroscopeViewController: UIViewController {
    
    // MARK: - Initialize Classes
    
    
    // MARK: - Define Constants / Variables
    var frequency: Float = SettingsAPI.shared.readFrequency() // Default Frequency
    
    
    // MARK: - Outlets
    // Gyroscope
    @IBOutlet weak var gyroscopeHeaderLabel: UILabel!
    @IBOutlet weak var gyroscopeXAxisLabel: UILabel!
    @IBOutlet weak var gyroscopeYAxisLabel: UILabel!
    @IBOutlet weak var gyroscopeZAxisLabel: UILabel!
    @IBOutlet weak var gyroscopeTableView: UITableView!
    @IBOutlet weak var UIToolBar: UIToolbar!
    
    
    // Refresh Rate
    @IBOutlet weak var motionHeaderLabel: UILabel!
    @IBOutlet weak var motionUpdateFrequencyLabel: UILabel!
    @IBOutlet weak var motionFrequencySliderOutlet: UISlider!
    @IBOutlet weak var motionMinLabel: UILabel!
    @IBOutlet weak var motionMaxLabel: UILabel!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        gyroscopeTableView.dataSource = self
        gyroscopeTableView.delegate = self
        
        UICustomization() // UI Customization
        frequencySliderSetup() // Set up Frequency Slider + Text
        startMotionUpdates() // Initial Start of CoreMotion
    }
    
    
    // MARK: - ViewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        CoreMotionAPI.shared.motionStopMethod()
    }
    
    
    // MARK: - Actions
    @IBAction func startUpdateMotionButton(_ sender: UIBarButtonItem) {
        CoreMotionAPI.shared.motionStartMethod()
    }
    
    
    @IBAction func stopUpdateMotionButton(_ sender: UIBarButtonItem) {
        CoreMotionAPI.shared.motionStopMethod()
    }
    
    
    @IBAction func motionFrequencyUpdateSlider(_ sender: UISlider) {
        self.frequency = Float(String(format: "%.1f", sender.value))!
        CoreMotionAPI.shared.sensorUpdateInterval = 1 / Double(self.frequency)  // Calculate frequency
        motionUpdateFrequencyLabel.text = "Frequency:".localized + " \(self.frequency) Hz"
    }
    
    
    @IBAction func deleteRecordedData(_ sender: Any) {
        CoreMotionAPI.shared.clearMotionArray {
            self.gyroscopeTableView.reloadData() // Reload TableView
        }
    }
    
    
    // MARK: - Methods
    func frequencySliderSetup() {
        CoreMotionAPI.shared.sensorUpdateInterval = 1 / Double(self.frequency)  // Calculate frequency
        motionUpdateFrequencyLabel.text = "Frequency:".localized + " \(frequency) Hz" // Setting Label
        motionFrequencySliderOutlet.value = frequency // Setting Slider
    }
    
    
    func startMotionUpdates() {
        CoreMotionAPI.shared.motionStartMethod()
        CoreMotionAPI.shared.motionCompletionHandler = { motion in
            
            guard let gyroX = motion.first?.gyroXAxis else { return }
            guard let gyroY = motion.first?.gyroYAxis else { return }
            guard let gyroZ = motion.first?.gyroZAxis else { return }
            
            // Change Gyrometer Labels
            self.gyroscopeXAxisLabel.text = "X-Axis:".localized + " \(String(format:"%.5f", gyroX)) rad/s"
            self.gyroscopeYAxisLabel.text = "Y-Axis:".localized + " \(String(format:"%.5f", gyroY)) rad/s"
            self.gyroscopeZAxisLabel.text = "Z-Axis:".localized + " \(String(format:"%.5f", gyroZ)) rad/s"
            
           // Reload TableView
            self.gyroscopeTableView.reloadData()
        }
    }
}


// MARK: - TableView
extension GyroscopeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreMotionAPI.shared.motionModelArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gyroscopeCell", for: indexPath) as! GyroTableViewCell
        
        cell.gyroTableViewCounter.text = "ID: \(CoreMotionAPI.shared.motionModelArray[indexPath.row].counter)"
        cell.gyroTableViewXAxis.text = "X: \(String(format:"%.5f", CoreMotionAPI.shared.motionModelArray[indexPath.row].gyroXAxis))"
        cell.gyroTableViewYAxis.text = "Y: \(String(format:"%.5f", CoreMotionAPI.shared.motionModelArray[indexPath.row].gyroYAxis))"
        cell.gyroTableviewZAxis.text = "Z: \(String(format:"%.5f", CoreMotionAPI.shared.motionModelArray[indexPath.row].gyroZAxis))"
        
        return cell
    }
    
    
    // MARK: - Customize Background / Label / Button
    func UICustomization() {
        self.view.customizedUIView()
        UIToolBar.customizedToolBar()
        gyroscopeHeaderLabel.customizedLabel(labelType: "Header")
        gyroscopeXAxisLabel.customizedLabel(labelType: "Standard")
        gyroscopeYAxisLabel.customizedLabel(labelType: "Standard")
        gyroscopeZAxisLabel.customizedLabel(labelType: "Standard")
        motionHeaderLabel.customizedLabel(labelType: "Header")
        motionUpdateFrequencyLabel.customizedLabel(labelType: "Standard")
        motionMinLabel.customizedLabel(labelType: "Standard")
        motionMaxLabel.customizedLabel(labelType: "Standard")
        gyroscopeTableView.customizedTableView()
    }
}
