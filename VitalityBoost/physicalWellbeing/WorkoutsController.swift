//
//  WorkoutsController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SafariServices

class WorkoutsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rcvdUsername = ""
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let workTableArray = ["Fitness Blender", "DAREBEE", "Muscle & Strength", "Asana Rebel", "@sydneycummingshoudyshell YouTube Channel", "MadFit YouTube Channel", "Tone & Tighten YouTube Channel", "growingannanas YouTube Channel", "SELF's Learn to Love Running Program", "Couch to Fitness", "YMCA at Home", "NHS Home Workout Videos"]
    let workoutDetailArray = ["https://www.fitnessblender.com/videos", "https://darebee.com/", "https://www.muscleandstrength.com/workout-routines", "https://asanarebel.com/en/", "https://www.youtube.com/@sydneycummingshoudyshell/videos", "https://www.youtube.com/@MadFit", "https://www.youtube.com/@toneandtighten", "https://www.youtube.com/@growingannanas", "https://www.self.com/story/learn-to-love-running-program-newsletter-sign-up", "https://couchtofitness.com/", "https://www.ymcahome.ca/fitness", "https://www.nhs.uk/better-health/get-active/home-workout-videos/"]
    let cellID = "cellID"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(rcvdUsername)
        table.dataSource = self
        table.delegate = self
        table.frame = subView.bounds
        mainView.addSubview(subView)

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workTableArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID
            )
        }
        cell?.textLabel?.text = workTableArray[indexPath.row]
        cell?.detailTextLabel?.text = workoutDetailArray[indexPath.row]
        return cell!
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let urlString = workoutDetailArray[indexPath.row]
            
            if let url = URL(string: urlString) {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            } else {
                print("Invalid URL: \(urlString)")
            }
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
