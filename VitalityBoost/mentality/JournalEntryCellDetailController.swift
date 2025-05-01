//
//  JournalEntryCellDetailController.swift
//  VitalityBoost
//
//  Created by Sam on 4/30/25.
//

import UIKit
import FirebaseFirestore
import Firebase

class JournalEntryCellDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  var rcvdUsername = ""
  let db = Firestore.firestore()
  var titleImageURL: URL?
  var entries: Journal?
  var journalReference: DocumentReference?
    

  var localCollection: LocalCollection<Journal>!

  static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> JournalEntryCellDetailController {
    let controller = storyboard.instantiateViewController(withIdentifier: "journalEntries") as! JournalEntryCellDetailController
    return controller
  }

  @IBOutlet var tableView: UITableView!
  @IBOutlet var titleView: EntryTitleView!

  //let backgroundView = UIImageView()

  override func viewDidLoad() {
    super.viewDidLoad()

      self.title = entries?.title

    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 140

    let query = journalReference!.collection("journal")
      //db.collection("users").document(rcvdUsername).collection("journal")
      //
      localCollection = LocalCollection(query: query) { [unowned self] (changes) in
      if self.localCollection.count == 0 {
        self.tableView.backgroundView = nil
        return
      } else {
        self.tableView.backgroundView = nil
      }
      var indexPaths: [IndexPath] = []

      for addition in changes.filter({ $0.type == .added }) {
        let index = self.localCollection.index(of: addition.document)!
        let indexPath = IndexPath(row: index, section: 0)
        indexPaths.append(indexPath)
      }

      self.tableView.insertRows(at: indexPaths, with: .automatic)
    }
  }

  deinit {
    localCollection.stopListening()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    localCollection.listen()
    titleView.populate(entries: entries!)
    
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    set {}
    get {
      return .lightContent
    }
  }

  @IBAction func didTapAddButton(_ sender: Any) {
//    let controller = NewReviewViewController.fromStoryboard()
//    controller.delegate = self
//    self.navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - UITableViewDataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return localCollection.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      tableView.register(UINib.self, forCellReuseIdentifier: "ReviewJournalEntryCell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewJournalEntryCell",
                                             for: indexPath) as! ReviewJournalEntryCell
    let review = localCollection[indexPath.row]
    cell.populate(entries: review)
    return cell
  }

}

class ReviewJournalEntryCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryLabel: UILabel!
    
    func populate(entries: Journal) {
      dateLabel.text = entries.date
      titleLabel.text = entries.title
      entryLabel.text = entries.description
  }

}

class EntryTitleView: UIView {
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var entryLabel: UILabel!
    

  func populate(entries: Journal) {
      dateLabel.text = entries.date
      entryLabel.text = entries.description
      titleLabel.text = entries.title
    
  }

}


