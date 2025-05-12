//
//  OrganizationAssistanceController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SafariServices

class OrganizationAssistanceController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rcvdUsername = ""
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let orgTableArray = ["Todoist", "Trello", "Google Keep", "Freedcamp", "TickTick", "Notion", "Combatting 'Clutter Creep'", "90/90 Decluttering Rule", "Creating a Decluttering Schedule", "5 Daily Habits for Feeling More Organized", "Staying Organized at Work", "Timeblocking Technique", "27 Great Tips to Keep Your Life Organized", "10 Principles to Organize Your Life", "Mastering Your Schedule: Effective Time Management Strategies for Success", "Time Management: A Realistic Approach", "10 Strategies for Better Time Management", "Want to Be More Productive? Use Time Blocking to Keep Your Days Stress-Free", "Busy? The Pomodoro Technique Can Work Wonders for Productivity—and All You Need Is a Timer", "Time Management in the Workplace: Strategies for Success"]
    let orgDetailArray = ["http://todoist.com/", "https://trello.com", "https://keep.google.com/", "https://freedcamp.com/", "https://ticktick.com/?language=en_us", "https://www.notion.com/", "https://www.realsimple.com/what-is-clutter-creep-and-how-to-prevent-it-11732368", "https://www.bhg.com/90-90-decluttering-rule-11679080", "https://www.thespruce.com/decluttering-schedule-11720221", "https://www.realsimple.com/daily-habits-to-feel-more-organized-11727474", "https://www.reddit.com/r/productivity/comments/m4f53b/best_ways_to_stay_organized_at_work", "https://en.wikipedia.org/wiki/Timeblocking", "https://zenhabits.net/27-great-tips-to-keep-your-life-organized", "https://www.todoist.com/inspiration/organize-your-life", "https://lpsonline.sas.upenn.edu/features/mastering-your-schedule-effective-time-management-strategies-success", "https://www.jacr.org/article/S1546-1440%2808%2900581-4/fulltext", "https://extension.uga.edu/publications/detail.html?number=C1042&title=time-management-10-strategies-for-better-time-management", "https://www.verywellmind.com/how-to-use-time-blocking-to-manage-your-day-4797509", "https://www.realsimple.com/pomodoro-technique-8777975", "https://www.globaltiesus.org/time-management-in-the-workplace-strategies-for-success"]
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
        return orgTableArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID
            )
        }
        cell?.textLabel?.text = orgTableArray[indexPath.row]
        cell?.detailTextLabel?.text = orgDetailArray[indexPath.row]
        return cell!
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let urlString = orgDetailArray[indexPath.row]
            
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
