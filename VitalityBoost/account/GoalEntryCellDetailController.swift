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
    
    
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var entryLabel: UITextView!
    
    
    var localCollection: LocalCollection<Goals>!
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> GoalEntryCellDetailController {
        let controller = storyboard.instantiateViewController(withIdentifier: "goalEntries") as! GoalEntryCellDetailController
        return controller
    }
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Goal Details"
        print(rcvdUsername)
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
        dateLabel.text = entries?.date
        titleLabel.text = entries?.title
        entryLabel.text = entries?.description
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func deleteEntry(_ sender: Any) {
        Task {
            await deleteGoal()
        }
    }
    
    func deleteGoal() async {
        
        let updateAlert = UIAlertController(title: "Are you sure you want to Delete this Goal?", message: "This cannot be undone.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                Task {
                    do {
                        try await self.db.collection("users").document(self.rcvdUsername).collection("goals").document(self.titleLabel.text!).delete()

                        let controller = GoalsController.fromStoryboard()
                        controller.rcvdUsername = self.rcvdUsername
                        self.navigationController?.pushViewController(controller, animated: true)
                    } catch {
                        print("Error deleting goal: \(error)")
                    }
                }
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        updateAlert.addAction(deleteAction)
        updateAlert.addAction(cancelAction)
        
        
        self.present(updateAlert, animated: true, completion: nil)
    }
    
    @IBAction func updateEntry(_ sender: Any) {
        Task {
            await updateGoal()
        }
    }
    
    func updateGoal() async {
        do{
            
            let date = dateLabel.text!
            let title = titleLabel.text!
            let description = entryLabel.text!
            
            _ = try await db.collection("users").document(rcvdUsername).collection("goals").document(titleLabel.text!).setData(["description": description,
                                                                                                                                                   "date": date,
                                                                                                                "title": title])
            
            let updateAlert = UIAlertController(title: "Updates Saved", message: "Your Entry \(titleLabel.text!) has been Updated.", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            updateAlert.addAction(dismiss)
            self.present(updateAlert, animated: true, completion: nil)
        }
        catch {
            print("Error Updating Entry")
        }
    }
    
    
}
