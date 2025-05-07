//
//  AccountController.swift
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
import CoreMedia

class AccountController: UIViewController {
    
    let db = Firestore.firestore()
    
    // USER INPUT FIELDS
    // ACCOUNT
    @IBOutlet weak var userUsername: UITextField!
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmailT: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var userAddress: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    
    //var username = ""
    public var rcvdUsername = ""
    var userUsernameEntry = ""
    var userPasswordEntry = ""
    var userFirstNameEntry = ""
    var userLastNameEntry = ""
    var userEmaiLEntry = ""
    var userPhoneEntry = ""
    var userAddressEntry = ""
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> AccountController {
        let controller = storyboard.instantiateViewController(withIdentifier: "Account") as! AccountController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (rcvdUsername == ""){
            print("do nothing")
        }else{
            Task{
                await login()
            }
        }
        print(rcvdUsername)
    }
    
    func login() async {
        do{
            
            var userUsernameEntry = ""
            var userPasswordEntry = ""
            var userFirstNameEntry = ""
            var userLastNameEntry = ""
            var userEmaiLEntry = ""
            var userPhoneEntry = ""
            var userAddressEntry = ""
            
            let document = try await db.collection("users").document(rcvdUsername).getDocument()
            if(document.exists){
                userUsernameEntry = document.get("username") as! String
                userPasswordEntry = document.get("password") as! String
                userFirstNameEntry = document.get("firstName") as! String
                userLastNameEntry = document.get("lastName") as! String
                userEmaiLEntry = document.get("email") as! String
                userPhoneEntry = document.get("phone") as! String
                userAddressEntry = document.get("address") as! String
                
                userUsername.text = userUsernameEntry
                userPassword.text = userPasswordEntry
                userFirstName.text = userFirstNameEntry
                userLastName.text = userLastNameEntry
                userEmailT.text = userEmaiLEntry
                userPhone.text = userPhoneEntry
                userAddress.text = userAddressEntry
                
            }else{
                let updateAlert = UIAlertController(title: "Username not Found", message: "Please try again or create a New Account.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(updateAlert, animated: true, completion: nil)
            }
            
            
        }
        catch {
            print("Error retrieving data or user skipped login.")
            
        }
    }
    
    
    
    
    @IBAction func saveUpdateBtn(_ sender: UIButton) {
        Task {
            await updateEntry()
        }
    }

    
    func updateEntry() async {
        do {
            _ = try await db.collection("users").document(userUsername.text!).setData([
                "username": userUsername.text!,
                "password": userPassword.text!,
                "firstName": userFirstName.text!,
                "lastName": userLastName.text!,
                "email": userEmailT.text!,
                "phone": userPhone.text!,
                "address": userAddress.text!,
            ])
            let docID = db.collection("users").document(userUsername.text!).documentID
            
            print("Document added/updated with ID: \(docID)")
            
            let updateAlert = UIAlertController(title: "Account Info Saved", message: "Document added.updated with ID: \(docID)", preferredStyle: .alert)
            updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(updateAlert, animated: true, completion: nil)
            
            
        }
        catch {
            print("Error adding document: \(error)")
            
        }
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        Task {
            await deleteAcct()
        }
    }
    
    func deleteAcct() async {
        do{
            let deleteEntry: Void = try await db.collection("users").document(rcvdUsername).delete()
            
            let updateAlert = UIAlertController(title: "Are you sure you want to Delete your Account?", message: "This cannot be undone. All of your Account Data, including Goals and Journal Entries, will be Deleted.", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler:  { _ in
                deleteEntry
                let controller = ViewController.fromStoryboard()
                controller.rcvdUsername = ""
                self.navigationController?.pushViewController(controller, animated: true)
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
    
    /*MARK: Navigation*/
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
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! BaseTabBarController
        tabBar.rcvdUsername = rcvdUsername
        
    }
}
