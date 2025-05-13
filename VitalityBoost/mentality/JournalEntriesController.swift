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
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No Journal Entries found."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
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
                    self.cancelAndGoBack()
                    return
                }
                
                let models = snapshot.documents.compactMap { Journal(dictionary: $0.data()) }

                        self.mentTableArray = models
                        self.documents = snapshot.documents
                        self.table.reloadData()

                        if models.isEmpty {
                            print("No entries found.")
                            showEmptyStateMessage()
                        } else {
                            hideEmptyStateMessage()
                        }
//                let models = snapshot.documents.map { (document) -> Journal in
//                    if let model = Journal(dictionary: document.data()) {
//                        return model
//                    } else {
//                        fatalError("Unable to initialize type \(String.self) with dictionary \(document.data())")
//                    }
//                }
//                self.mentTableArray = models
//                self.documents = snapshot.documents
//                self.table.reloadData()
            }

    }
    
    func cancelAndGoBack() {
        stopObserving()
        
        let updateAlert = UIAlertController(title: "Login Required", message: "You cannot view your Journal Entries unless you are Logged In. Please login to your Account and come back to view your Entries.", preferredStyle: .alert)
        updateAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
            self.navigationController?.popViewController(animated: true)
            }))
        updateAlert.addAction(UIAlertAction(title: "Login", style: .default, handler: {_ in
            let controller = LoginController.fromStoryboard()
            self.navigationController?.pushViewController(controller, animated: true)
        }))
            self.present(updateAlert, animated: true, completion: nil)
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
        table.dataSource = self
        table.delegate = self
        mainView.addSubview(subView)
        subView.addSubview(table)
        table.frame = subView.bounds
        subView.addSubview(emptyLabel)
        emptyLabel.frame = subView.bounds
        //query = baseQuery()
        print("viewDidLoad")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    private func showEmptyStateMessage() {
        emptyLabel.isHidden = false
        table.isHidden = true
    }

    private func hideEmptyStateMessage() {
        emptyLabel.isHidden = true
        table.isHidden = false
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
        if !rcvdUsername.isEmpty {
                    query = baseQuery()
                    observeQuery()
                } else {
                    cancelAndGoBack()
                }
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
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let date = mentTableArray[indexPath.row].date
        let title = mentTableArray[indexPath.row].title
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "TableViewCell")
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = date
        
        return cell
        }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      let controller = JournalEntryCellDetailController.fromStoryboard()
      controller.entries = mentTableArray[indexPath.row]
      controller.journalReference = documents[indexPath.row].reference
        controller.rcvdUsername = rcvdUsername
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

