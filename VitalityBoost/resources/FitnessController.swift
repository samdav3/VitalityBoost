//
//  FitnessController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit


class FitnessController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let fitTitleArray = ["Exercise Is Medicine", "Harvard: Exercise & Fitness Benefits", "NIH: Health Benefits of Exercise", "CDC: Benefits of Physical Activity"]
    let fitDetailArray = ["https://www.amazon.com/Exercise-Medicine-Physical-Activity-Boosts/dp/0190685468/ref=asc_df_0190685468?mcid=b31fd8ee41c53e3b9a2d9ec70834fbb9&tag=hyprod-20&linkCode=df0&hvadid=693552282123&hvpos=&hvnetw=g&hvrand=10105925173890605268&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9021434&hvtargid=pla-872611948063&psc=1", "https://www.health.harvard.edu/topics/exercise-and-fitness", "https://pmc.ncbi.nlm.nih.gov/articles/PMC6027933/", "https://www.cdc.gov/physical-activity-basics/benefits/index.html"]
    //let imageArray = ["exercise-med.png", "harvard-health.png", "nat-lib-med.png"]
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
        return fitTitleArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID
            )
        }
        
        cell?.textLabel?.text = fitTitleArray[indexPath.row]
        cell?.detailTextLabel?.text = fitDetailArray[indexPath.row]
        //cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
        return cell!
        }
    
    }
