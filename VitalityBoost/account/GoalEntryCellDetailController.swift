//
//  GoalEntryCellDetailController.swift
//  VitalityBoost
//
//  Created by Sam on 5/1/25.
//

import UIKit
import FirebaseFirestore
import Firebase

class GoalEntryCellDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  var rcvdUsername = ""
  let db = Firestore.firestore()
  var titleImageURL: URL?
  var entries: Goals?
  var goalReference: DocumentReference?
    

  var localCollection: LocalCollection<Goals>!

  static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> GoalEntryCellDetailController {
    let controller = storyboard.instantiateViewController(withIdentifier: "goalEntries") as! GoalEntryCellDetailController
    return controller
  }

  @IBOutlet var tableView: UITableView!
  @IBOutlet var titleView: GoalEntryTitleView!

  //let backgroundView = UIImageView()

  override func viewDidLoad() {
    super.viewDidLoad()

      self.title = entries?.title

    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 140

    let query = goalReference!.collection("goals")
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
      tableView.register(UINib.self, forCellReuseIdentifier: "ReviewGoalEntryCell")
    let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewGoalEntryCell",
                                             for: indexPath) as! ReviewGoalEntryCell
    let review = localCollection[indexPath.row]
    cell.populate(entries: review)
    return cell
  }

}

class ReviewGoalEntryCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var entryLabel: UILabel!
    
    func populate(entries: Goals) {
      dateLabel.text = entries.date
      titleLabel.text = entries.title
      entryLabel.text = entries.description
  }

}

class GoalEntryTitleView: UIView {
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var entryLabel: UILabel!
    

  func populate(entries: Goals) {
      dateLabel.text = entries.date
      entryLabel.text = entries.description
      titleLabel.text = entries.title
    
  }

}
