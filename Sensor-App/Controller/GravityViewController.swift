//
//  GravityViewController.swift
//  Sensor-App
//
//  Created by Volker Schmitt on 25.05.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//

// MARK: - Import
import UIKit


// MARK: - TableViewCell Class
class GravityTableViewCell: UITableViewCell {
    @IBOutlet weak var gravityTableViewCounter: UILabel!
    @IBOutlet weak var gravityTableViewXAxis: UILabel!
    @IBOutlet weak var gravityTableviewYAxis: UILabel!
    @IBOutlet weak var gravityTableViewZAxis: UILabel!
}


// MARK: - Class Definition
class GravityViewController: UIViewController {
    
    // MARK: - Initialize Classes
    
    
    // MARK: - Define Constants / Variables
    var frequency: Float = SettingsAPI.shared.readFrequency() // Default Frequency
    
    
    // MARK: - Outlets
    // Gravity
    @IBOutlet weak var gravityHeaderLabel: UILabel!
    @IBOutlet weak var gravityXAxisLabel: UILabel!
    @IBOutlet weak var gravityYAxisLabel: UILabel!
    @IBOutlet weak var gravityZAxisLabel: UILabel!
    @IBOutlet weak var gravityTableView: UITableView!
    
    
    // Refresh Rate
    @IBOutlet weak var motionHeaderLabel: UILabel!
    @IBOutlet weak var motionUpdateFrequencyLabel: UILabel!
    @IBOutlet weak var motionFrequencySliderOutlet: UISlider!
    @IBOutlet weak var motionMinLabel: UILabel!
    @IBOutlet weak var motionMaxLabel: UILabel!
    @IBOutlet weak var UIToolBar: UIToolbar!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        gravityTableView.dataSource = self
        gravityTableView.delegate = self
        
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
            self.gravityTableView.reloadData() // Reload TableView
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
            
            guard let gravityX = motion.first?.gravityXAxis else { return }
            guard let gravityY = motion.first?.gravityYAxis else { return }
            guard let gravityZ = motion.first?.gravityZAxis else { return }
            
            // Change Gravity Labels
            self.gravityXAxisLabel.text = "X-Axis:".localized + " \(String(format:"%.5f", gravityX)) g (9,81 m/s^2)"
            self.gravityYAxisLabel.text = "Y-Axis:".localized + " \(String(format:"%.5f", gravityY)) g (9,81 m/s^2)"
            self.gravityZAxisLabel.text = "Z-Axis:".localized + " \(String(format:"%.5f", gravityZ)) g (9,81 m/s^2)"
            
             // Reload TableView
            self.gravityTableView.reloadData()
        }
    }
}


// MARK: - TableView
extension GravityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreMotionAPI.shared.motionModelArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gravityCell", for: indexPath) as! GravityTableViewCell
        
        cell.gravityTableViewCounter.text = "ID: \(CoreMotionAPI.shared.motionModelArray[indexPath.row].counter)"
        cell.gravityTableViewXAxis.text = "X: \(String(format:"%.5f", CoreMotionAPI.shared.motionModelArray[indexPath.row].gravityXAxis))"
        cell.gravityTableviewYAxis.text = "Y: \(String(format:"%.5f", CoreMotionAPI.shared.motionModelArray[indexPath.row].gravityYAxis))"
        cell.gravityTableViewZAxis.text = "Z: \(String(format:"%.5f", CoreMotionAPI.shared.motionModelArray[indexPath.row].gravityZAxis))"
        
        return cell
    }
    
    
    // MARK: - Customize Background / Label / Button
    func UICustomization() {
        self.view.customizedUIView()
        UIToolBar.customizedToolBar()
        gravityHeaderLabel.customizedLabel(labelType: "Header")
        gravityXAxisLabel.customizedLabel(labelType: "Standard")
        gravityYAxisLabel.customizedLabel(labelType: "Standard")
        gravityZAxisLabel.customizedLabel(labelType: "Standard")
        motionHeaderLabel.customizedLabel(labelType: "Header")
        motionUpdateFrequencyLabel.customizedLabel(labelType: "Standard")
        motionMinLabel.customizedLabel(labelType: "Standard")
        motionMaxLabel.customizedLabel(labelType: "Standard")
        gravityTableView.customizedTableView()
    }
}
