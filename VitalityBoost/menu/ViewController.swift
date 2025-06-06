//
//  ViewController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    public var rcvdUsername = ""
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> ViewController {
        let controller = storyboard.instantiateViewController(withIdentifier: "Home") as! ViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(rcvdUsername)
        
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        performSegue(withIdentifier: "home", sender: UIButton.self)
        performSegue(withIdentifier: "login", sender: UIButton.self)
        performSegue(withIdentifier: "fitness", sender: UIButton.self)
        performSegue(withIdentifier: "workouts", sender: UIButton.self)
        performSegue(withIdentifier: "recipes", sender: UIButton.self)
        performSegue(withIdentifier: "calendar", sender: UIButton.self)
        performSegue(withIdentifier: "journal", sender: UIButton.self)
        performSegue(withIdentifier: "goals", sender: UIButton.self)
        performSegue(withIdentifier: "contactInfo", sender: UIButton.self)
        performSegue(withIdentifier: "affordableOptions", sender: UIButton.self)
        performSegue(withIdentifier: "personalResearch", sender: UIButton.self)
        performSegue(withIdentifier: "supplements", sender: UIButton.self)
        performSegue(withIdentifier: "recipeSearch", sender: UIButton.self)
        performSegue(withIdentifier: "organizationAssistance", sender: UIButton.self)
        performSegue(withIdentifier: "journalEntries", sender: UIButton.self)
        performSegue(withIdentifier: "mentalHealthResources", sender: UIButton.self)
        performSegue(withIdentifier: "addGoal", sender: UIButton.self)
        performSegue(withIdentifier: "createAccount", sender: UIButton.self)
        performSegue(withIdentifier: "entryDetails", sender: UIButton.self)
        performSegue(withIdentifier: "backToGoals", sender: UIButton.self)
        
        
        
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
        else if segue.identifier == "entryDetails"{
            let entryDetailsVC = segue.destination as! JournalEntryCellDetailController
                entryDetailsVC.rcvdUsername = rcvdUsername
                entryDetailsVC.navigationItem.title = "Entry Details"
        }
        else if segue.identifier == "toAccount"{
            let toAccountVC = segue.destination as! AccountController
            toAccountVC.rcvdUsername = rcvdUsername
            toAccountVC.navigationItem.title = "Account"
        }
        else if segue.identifier == "backToLogin"{
            let loginAgainVC = segue.destination as! LoginController
            loginAgainVC.navigationItem.title = "Login"
        }
    }
    
    

}

