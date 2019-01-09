//
//  LeftPaneTableViewController.swift
//  CassI
//
//  Created by Thomas Etcheverria on 11/12/2018.
//  Copyright © 2018 Belette Team. All rights reserved.
//

import UIKit
import SideMenu

class LeftPaneTableViewController: UITableViewController {

//    var operatorNames = ["Simplifier (simplify)","Développer (expand)","Dériver (diff)","Intégrer (integral)","Résoudre (solve)"]
    var operatorNames = [
        NSLocalizedString("simplify", comment: "Simplify operator names"),
        NSLocalizedString("expand", comment: "Expand operator names"),
        NSLocalizedString("diff", comment: "Diff operator names"),
        NSLocalizedString("integral", comment: "Integral operator names"),
        NSLocalizedString("solve", comment: "Solve operator names"),
    ]
    var operatorFunc = ["simplify","expand","d","integral","roots"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return operatorNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = operatorNames[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIApplication.shared.windows[0].rootViewController as! ViewController
        dismiss(animated: true, completion: nil)
        controller.performOperator(choosenOperator: operatorFunc[indexPath.row])
    }
    
    
//    // This function is called before the segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        // get a reference to the second view controller
//        let secondViewController = segue.destination as! SecondViewController
//        if segue.identifier == "Segue"{
//            let row = tableView.indexPathForSelectedRow!.row
//            secondViewController.receivedData = carteFiles[row]
//        }
//        else{
//            secondViewController.receivedData = "null"
//        }
//        // set a variable in the second view controller with the data to pass
//    }

}
