//
//  ViewController.swift
//  Tippy
//
//  Created by Romell Bolton on 9/28/19.
//  Copyright © 2019 Romell Bolton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let indexPathData = defaults.data(forKey: "Default Tip Selection")
        if let path = indexPathData {
            let indexPath = NSKeyedUnarchiver.unarchiveObject(with: path) as? IndexPath
            if let path = indexPath {
                self.tipControl.selectedSegmentIndex = path.row
            }
        }
        
        self.billField.becomeFirstResponder()
    }

    @IBAction func onTap(_ sender: Any) {
        print("Hello")
        
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        // Get the bill amount
        let bill = Double(billField.text!) ?? 0
        
        // Calculate the tip and total
        let tipPercentages = [0.15, 0.18, 0.2, 0.25]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

