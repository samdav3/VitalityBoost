//
//  JournalController.swift
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

class JournalController: UIViewController {
    
    let db = Firestore.firestore()
    var rcvdUsername = ""
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var journalEntry: UITextView!
    @IBOutlet weak var entryDate: UIDatePicker!
    @IBOutlet weak var entryTitle: UITextField!
    
    var entryTitleText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(rcvdUsername)
        dateFormatter.dateStyle = .medium
        

    }
    
    override func viewDidAppear(_ animated: Bool){
        let tabBar = tabBarController as! BaseTabBarController
        rcvdUsername = String(describing: tabBar.rcvdUsername)
        print(rcvdUsername)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! BaseTabBarController
        tabBar.rcvdUsername = String(rcvdUsername)
        
    }
        
    @IBAction func saveEntry(_ sender: UIButton) {
        
        if (rcvdUsername == ""){
            let updateAlert = UIAlertController(title: "Unable to Save Entry", message: "You must be logged in to Save your Journal Entries.", preferredStyle: .alert)
            updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(updateAlert, animated: true, completion: nil)
            
        }else {
            
            Task{
                await saveEntry()
            }
            
        }
        
        
    }
    
    @IBAction func discardEntry(_ sender: UIButton) {
        entryTitle.text = ""
        journalEntry.text = ""
        entryDate.date = Date.now
    }
    
    
    func saveEntry() async {
        let date = dateFormatter.string(from: entryDate.date)
        entryTitleText = entryTitle.text! as String
        let description = journalEntry.text! as String
        do{
            _ = try await db.collection("users").document(rcvdUsername).collection("journal").document(date).setData([
                "description": description,
                "date": date,
                "title": entryTitleText
            ])
            let docID = db.collection("users").document(rcvdUsername).collection("journal").document(date).documentID
            print("Document added with ID \(docID)")
            
            let updateAlert = UIAlertController(title: "Entry Saved", message: "Your Entry has been added to your Accounts Journal Entries!", preferredStyle: .alert)
            updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                let controller = JournalEntriesController.fromStoryboard()
                controller.rcvdUsername = self.rcvdUsername
                self.navigationController?.pushViewController(controller, animated: true)
            }))
                self.present(updateAlert, animated: true, completion: nil)
        }
        catch{
            print("Error saving Entry")
        }
        entryTitle.text = ""
        journalEntry.text = ""
        entryDate.date = Date.now
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
