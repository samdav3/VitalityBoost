//
//  JournalEntryCellDetailController.swift
//  VitalityBoost
//
//  Created by Sam on 4/30/25.
//

import UIKit
import FirebaseFirestore
import Firebase

class JournalEntryCellDetailController: UIViewController {
    
  var rcvdUsername = ""
  let db = Firestore.firestore()
  var entries: Journal?
  var journalReference: DocumentReference?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var entryLabel: UITextView!
    
  var localCollection: LocalCollection<Journal>!

  static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> JournalEntryCellDetailController {
    let controller = storyboard.instantiateViewController(withIdentifier: "journalEntries") as! JournalEntryCellDetailController
    return controller
  }


  override func viewDidLoad() {
    super.viewDidLoad()
      print(rcvdUsername)
      self.title = "Journal Entry Details"

    let query = journalReference!.collection("journal")
      
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


    @IBAction func deleteEntry(_ sender: Any)  {
        Task{
            await deleteJournal()
        }
    }
    
    func deleteJournal() async {
        do{
            let deleteEntry: Void = try await db.collection("users").document(rcvdUsername).collection("journal").document(entries!.date).delete()
            
            let updateAlert = UIAlertController(title: "Are you sure you want to Delete this Entry?", message: "This cannot be undone.", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler:  { _ in
                deleteEntry
                self.navigationController?.popViewController(animated: true)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            updateAlert.addAction(deleteAction)
            updateAlert.addAction(cancelAction)
            self.present(updateAlert, animated: true, completion: nil)
            
        }
        catch{
            print("Error Deleting Entry")
        }
    }

    @IBAction func updateEntry(_ sender: Any) {
        Task {
            await updateJournal()
        }
    }
    
    func updateJournal() async {
        do{
            
            let date = dateLabel.text!
            let title = titleLabel.text!
            let description = entryLabel.text!
            
            _ = try await db.collection("users").document(rcvdUsername).collection("journal").document(dateLabel.text!).setData(["description": description,
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




