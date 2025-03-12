//
//  AffordableOptionsController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit

class AffordableOptionsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let affTitleArray = ["Free At Home Workouts", "Better Me", "Apple Fitness", "DAREBEE", "Planet Fitness", "The Edge Fitness Clubs", "MadFit YouTube Channel", "Tone & Tighten YouTube Channel", "growingannanas YouTube Channel", ""]
    let affDetailArray = ["https://www.muscleandstrength.com/workouts/home", "https://betterme.world/", "https://www.apple.com/apple-fitness-plus/", "https://darebee.com/workouts.html", "https://www.planetfitness.com/", "https://www.theedgefitnessclubs.com/", "https://www.youtube.com/@MadFit", "https://www.youtube.com/@toneandtighten", "https://www.youtube.com/@growingannanas", ""]
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
        return affTitleArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID
            )
        }
        cell?.textLabel?.text = affTitleArray[indexPath.row]
        cell?.detailTextLabel?.text = affDetailArray[indexPath.row]
        return cell!
        }
        
    }
