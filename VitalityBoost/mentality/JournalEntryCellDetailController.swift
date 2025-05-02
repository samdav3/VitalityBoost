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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryLabel: UITextView!
    
  var localCollection: LocalCollection<Journal>!

  static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> JournalEntryCellDetailController {
    let controller = storyboard.instantiateViewController(withIdentifier: "journalEntries") as! JournalEntryCellDetailController
    return controller
  }


  override func viewDidLoad() {
    super.viewDidLoad()

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


  @IBAction func didTapAddButton(_ sender: Any) {
      //ACTIONS FOR DELETE BUTTON HERE
  }


}




