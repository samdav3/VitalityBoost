//
//  JournalEntriesController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseAppCheck
import FirebaseDatabaseInternal

class JournalEntriesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    var rcvdUsername = ""
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    private var mentTableArray: [Journal] = []
    private var documents: [DocumentSnapshot] = []
    
    fileprivate var query: Query? {
      didSet {
        if let listener = listener {
          listener.remove()
          observeQuery()
        }
      }
    }

    private var listener: ListenerRegistration?

    fileprivate func observeQuery() {
      guard let query = query else { return }
      stopObserving()

        listener = query.addSnapshotListener { [unowned self] (snapshot, error) in
          guard let snapshot = snapshot else {
            print("Error fetching snapshot results: \(error!)")
            return
          }
          let models = snapshot.documents.map { (document) -> Journal in
            if let model = Journal(dictionary: document.data()) {
              return model
            } else {
              // Don't use fatalError here in a real app.
              fatalError("Unable to initialize type \(String.self) with dictionary \(document.data())")
            }
          }
          self.mentTableArray = models
          self.documents = snapshot.documents

//          if self.documents.count > 0 {
//              self.tableView.backgroundView = nil
//          } else {
//            self.tableView.backgroundView = self.backgroundView
//          }
            
            self.table.reloadData()
        }


    }

    fileprivate func stopObserving() {
      listener?.remove()
    }

    fileprivate func baseQuery() -> Query {
      return Firestore.firestore().collection("users").document(rcvdUsername).collection("journal").limit(to: 50)
    }
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> JournalEntriesController {
        let controller = storyboard.instantiateViewController(withIdentifier: "Main") as! JournalEntriesController
        return controller
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(rcvdUsername)
        //Task{
            //await loadEntries()
            print(mentTableArray)
        //}
        table.dataSource = self
        table.delegate = self
        mainView.addSubview(subView)
        subView.addSubview(table)
        table.frame = subView.bounds
        query = baseQuery()
        print("viewDidLoad")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        print("viewWillAppear")
      observeQuery()
    }
    
    override func viewDidAppear(_ animated: Bool){
        let tabBar = tabBarController as! BaseTabBarController
        rcvdUsername = String(describing: tabBar.rcvdUsername)
        print(rcvdUsername)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! BaseTabBarController
        tabBar.rcvdUsername = String(rcvdUsername)
        stopObserving()
    }
    
    deinit {
      listener?.remove()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentTableArray.count
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let date = mentTableArray[indexPath.row].date
        let title = mentTableArray[indexPath.row].title
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = date
//        let menTableArray = mentTableArray[indexPath.row]
//        cell.populate(mentTableArray: menTableArray)
        
        return cell
        }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      let controller = JournalEntryCellDetailController.fromStoryboard()
      controller.entries = mentTableArray[indexPath.row]
      controller.journalReference = documents[indexPath.row].reference
      self.navigationController?.pushViewController(controller, animated: true)
    }
    

    
    /*MARK: - Navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "home"{
            let homeVC = segue.destination as! ViewController
            homeVC.rcvdUsername = rcvdUsername
            homeVC.navigationItem.title = "Home"
        }
        else if segue.identifier == "login"{
            let loginVC = segue.destination as! LoginController
            //loginVC.username = rcvdUsername
            loginVC.navigationItem.title = "Login"
        }
        else if segue.identifier == "createAccount"{
            let createAccountVC = segue.destination as! CreateAccountController
            createAccountVC.rcvdUsername = rcvdUsername
            createAccountVC.navigationItem.title = "Create Account"
        }
        else if segue.identifier == "fitness"{
            let fitnessVC = segue.destination as! FitnessController
            fitnessVC.rcvdUsername = rcvdUsername
            fitnessVC.navigationItem.title = "Fitness"
        }
        else if segue.identifier == "workouts"{
            let workoutsVC = segue.destination as! WorkoutsController
            workoutsVC.rcvdUsername = rcvdUsername
            workoutsVC.navigationItem.title = "Workouts"
        }
        else if segue.identifier == "recipes" {
            let recipesVC = segue.destination as! RecipesController
            recipesVC.rcvdUsername = rcvdUsername
            recipesVC.navigationItem.title = "Recipes"
        }
        else if segue.identifier == "calendar" {
            let calendarVC = segue.destination as! CalendarController
            calendarVC.rcvdUsername = rcvdUsername
            calendarVC.navigationItem.title = "Calendar"
        }
        else if segue.identifier == "journal" {
            let journalVC = segue.destination as! JournalController
            journalVC.rcvdUsername = rcvdUsername
            journalVC.navigationItem.title = "Journal"
        }
        else if segue.identifier == "goals" {
            let goalsVC = segue.destination as! GoalsController
            goalsVC.rcvdUsername = rcvdUsername
            goalsVC.navigationItem.title = "Goals"
        }
        else if segue.identifier == "contactInfo" {
            let contactInfoVC = segue.destination as! AccountController
            contactInfoVC.rcvdUsername = rcvdUsername
            contactInfoVC.navigationItem.title = "Contact Info"
        }
        else if segue.identifier == "affordableOptions" {
            let affordableOptionsVC = segue.destination as! AffordableOptionsController
            affordableOptionsVC.rcvdUsername = rcvdUsername
            affordableOptionsVC.navigationItem.title = "Affordable Options"
        }
        else if segue.identifier == "personalResearch" {
            let personalResearchVC = segue.destination as! PersonalResearchController
            personalResearchVC.rcvdUsername = rcvdUsername
            personalResearchVC.navigationItem.title = "Personal Research"
        }
        else if segue.identifier == "supplements" {
            let supplementsVC = segue.destination as! SupplementsController
            supplementsVC.rcvdUsername = rcvdUsername
            supplementsVC.navigationItem.title = "Supplements"
        }
        else if segue.identifier == "recipeSearch" {
            let recipeSearchVC = segue.destination as! RecipesSearchController
            recipeSearchVC.rcvdUsername = rcvdUsername
            recipeSearchVC.navigationItem.title = "Recipe Search"
        }
        else if segue.identifier == "organizationAssistance" {
            let organizationAssistanceVC = segue.destination as! OrganizationAssistanceController
            organizationAssistanceVC.rcvdUsername = rcvdUsername
            organizationAssistanceVC.navigationItem.title = "Organization Assistance"
        }
        else if segue.identifier == "journalEntries" {
            let journalEntriesVC = segue.destination as! JournalEntriesController
            journalEntriesVC.rcvdUsername = rcvdUsername
            journalEntriesVC.navigationItem.title = "Journal Entries"
        }
        else if segue.identifier == "mentalHealthResources" {
            let mentalHealthResourcesVC = segue.destination as! MentalHealthResourcesController
            mentalHealthResourcesVC.rcvdUsername = rcvdUsername
            mentalHealthResourcesVC.navigationItem.title = "Mental Health Resources"
        }
        else if segue.identifier == "addGoal" {
            let addGoalVC = segue.destination as! AddGoalController
            addGoalVC.rcvdUsername = rcvdUsername
            addGoalVC.navigationItem.title = "Add Goal"
        }
    }
    
    
        
    }

///main class ends here
///

//class TableViewCell: UITableViewCell {
//    
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    
//    
////    let label1 = {
////     let d = UILabel()
////         d.textColor = UIColor.darkGray
////         d.textAlignment = .center
////        d.text = ""
////        d.font = UIFont(name: "Montserrat", size: 30)
////     return d
////    }()
////    let label2 = {
////     let t = UILabel()
////         t.textColor = UIColor.darkGray
////         t.textAlignment = .center
////        t.text = ""
////        t.font = UIFont(name: "Montserrat", size: 30)
////     return t
////    }()
////    let label3 = {
////     let e = UILabel()
////         e.textColor = UIColor.darkGray
////         e.textAlignment = .center
////        e.text = ""
////        e.font = UIFont(name: "Montserrat", size: 30)
////     return e
////    }()
////
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: "TableViewCell")
//
//        addSubview(titleLabel)
//        addSubview(dateLabel)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func populate(mentTableArray: Journal) {
//        
////        label1.text = mentTableArray.date
////        label2.text = mentTableArray.title
////        label3.text = mentTableArray.description
//        dateLabel.text = mentTableArray.date
//        titleLabel.text = mentTableArray.title
////        entryLabel.text = mentTableArray.description
//        //trashIcon.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
////        let image = imageURL(from: restaurant.name)
////        thumbnailView.sd_setImage(with: image)
//    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
////        thumbnailView.sd_cancelCurrentImageLoad()
//}
//}
////    
    
    //@IBOutlet weak private var trashIcon: UIButton!

    





//fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
//guard let input = input else { return nil }
//return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
//}

    



//    func loadEntries() async {
//
//        return db.collection("users").document(rcvdUsername).collection("journal").limit(to: 50)
//        //collection("restaurants").limit(to: 50)
//    }
//        do{
//            let entries = try await db.collection("users").document(rcvdUsername).collection("journal").getDocuments()
//
//            //var entryData = ""
//
//            if (entries.isEmpty){
//                print("failure")
//                let updateAlert = UIAlertController(title: "No Entry History Found", message: "You have no saved Journal Entries in your Account.", preferredStyle: .alert)
//                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//                self.present(updateAlert, animated: true, completion: nil)
//
//            }else{
//                let querySnapshot = try await db.collection("users").document(rcvdUsername).collection("journal").getDocuments()
//                for document in querySnapshot.documents{
//                    mentTableArray.append("\(document.get("date") as! String)")
//                }
//            }
//        }
//        catch{
//            print("Error retrieving data from database.")
//        }
//
