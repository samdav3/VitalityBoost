//
//  WorkoutsController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit

class WorkoutsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rcvdUsername = ""
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let workTableArray = ["", "", "", ""]
    let cellID = "cellID"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        table.frame = subView.bounds
        mainView.addSubview(subView)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workTableArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: cellID
            )
        }
        cell?.textLabel?.text = workTableArray[indexPath.row]
        return cell!
        }
        
    }
