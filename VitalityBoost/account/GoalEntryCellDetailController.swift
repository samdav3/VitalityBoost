//
//  GoalEntryCellDetailController.swift
//  VitalityBoost
//
//  Created by Sam on 5/1/25.
//

import UIKit
import FirebaseFirestore
import Firebase

class GoalEntryCellDetailController: UIViewController {
    
    var rcvdUsername = ""
    let db = Firestore.firestore()
    var entries: Goals?
    var goalReference: DocumentReference?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryLabel: UITextView!
    //@IBOutlet weak var entryLabel: UILabel!
    
    
    var localCollection: LocalCollection<Goals>!
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> GoalEntryCellDetailController {
        let controller = storyboard.instantiateViewController(withIdentifier: "goalEntries") as! GoalEntryCellDetailController
        return controller
    }
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Goal Details"
        
        let query = goalReference!.collection("goals")
        localCollection = LocalCollection(query: query) { [unowned self] (changes) in
            var indexPaths: [IndexPath] = []
            for addition in changes.filter({ $0.type == .added }) {
                let index = self.localCollection.index(of: addition.document)!
                let indexPath = IndexPath(row: index, section: 0)
                indexPaths.append(indexPath)
            }
            
            
        }
    }
    
    deinit {
        localCollection.stopListening()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localCollection.listen()
        //titleView.populate(entries: entries!)
        dateLabel.text = entries?.date
        titleLabel.text = entries?.title
        entryLabel.text = entries?.description
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        //ACTIONS FOR DELETING GOAL HERE
    }
    
    
    
}
