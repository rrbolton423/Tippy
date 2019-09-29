//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Romell Bolton on 9/28/19.
//  Copyright © 2019 Romell Bolton. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indexPathData = defaults.data(forKey: "Default Tip Selection")
        if let data = indexPathData {
            let indexPath = NSKeyedUnarchiver.unarchiveObject(with: data) as? IndexPath
            if let path = indexPath {
                self.tableView.selectRow(at: path, animated: false, scrollPosition: UITableView.ScrollPosition.none)
                self.tableView(tableView, didSelectRowAt: path)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please select the default tip percentage:"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt: IndexPath) ->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipPercentage")
        
        var percentage = "0"
        
        if cellForRowAt.row == 0  {
            percentage = "15%"
        } else if cellForRowAt.row == 1 {
            percentage = "18%"
        } else if cellForRowAt.row == 2 {
            percentage = "20%"
        } else if cellForRowAt.row == 3 {
            percentage = "25%"
        }
        
        cell?.textLabel?.text = percentage
        cell?.accessoryType = UITableViewCell.AccessoryType.none
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        let data = NSKeyedArchiver.archivedData(withRootObject: indexPath)
        defaults.set(data, forKey: "Default Tip Selection")
        defaults.synchronize()
    }
    
}
