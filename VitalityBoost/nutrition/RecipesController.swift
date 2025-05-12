//
//  RecipesController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SafariServices

class RecipesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rcvdUsername = ""
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let recTableArray = ["NHLBI Deliciously Healthy Eating Recipes", "Harvard T.H. Chan School of Public Health – Complete Recipe List", "Nutrition.gov Recipe Collection", "Skinnytaste Simple: Easy, Healthy Recipes with 7 Ingredients or Fewer", "Flavcity's 5 Ingredient Meals: 50 Easy & Tasty Recipes", "Eat Like a Girl: 100+ Delicious Recipes to Balance Hormones, Boost Energy, and Burn Fat", "EatingWell's Low-Carb Recipes", "Delish's 105 Low-Carb Recipes", "Skinnytaste's Low-Carb Recipes", "AHA Budget-Friendly Heart Health Recipes", "Mayo Clinic Heart Healthy Recipes", "Food Network: 23 Healthy Recipes That Will Save You Money", "Taste of Home: 50 Cheap, Healthy Meals", "Better Homes & Gardens: 32 Cheap, Healthy Meals Under $3 Per Serving", "Budget Bytes"]
    let recDetailArray = ["https://healthyeating.nhlbi.nih.gov/", "https://nutritionsource.hsph.harvard.edu/recipes/", "https://www.nutrition.gov/recipes", "https://www.amazon.com/Skinnytaste-Simple-Healthy-Ingredients-Cookbook/dp/0593235614/ref=asc_df_0593235614?mcid=a5c3b44e93cf3e8d8bdb39c9d82f9490&hvocijid=16344521762642762131-0593235614-&hvexpln=73&tag=hyprod-20&linkCode=df0&hvadid=721245378154&hvpos=&hvnetw=g&hvrand=16344521762642762131&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9021433&hvtargid=pla-2281435177898&psc=1", "https://www.amazon.com/Flavcitys-Ingredient-Meals-Recipes-Ingredients/dp/1642508063/ref=asc_df_1642508063?mcid=924daf87637931abb59fbc206c7b89b8&hvocijid=17333562098526070308-1642508063-&hvexpln=73&tag=hyprod-20&linkCode=df0&hvadid=721245378154&hvpos=&hvnetw=g&hvrand=17333562098526070308&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9021433&hvtargid=pla-2281435176418&psc=1", "https://www.amazon.com/Eat-Like-Girl-Delicious-Hormones/dp/1401979440", "https://www.eatingwell.com/recipes/18013/lifestyle-diets/low-carb/", "https://www.delish.com/cooking/recipe-ideas/g3593/low-carb-recipes/", "https://www.skinnytaste.com/recipes/low-carb/", "https://recipes.heart.org/en/collections/lifestyles/budget-friendly", "https://www.mayoclinic.org/healthy-lifestyle/recipes/heart-healthy-recipes/rcs-20077163", "https://www.foodnetwork.com/healthy/photos/budget-friendly-healthy-dinners", "https://www.tasteofhome.com/collection/cheap-healthy-meals/", "https://www.bhg.com/recipes/healthy/dinner/cheap-heart-healthy-dinner-ideas/", "https://www.budgetbytes.com/"]
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
        return recTableArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID
            )
        }
        cell?.textLabel?.text = recTableArray[indexPath.row]
        cell?.detailTextLabel?.text = recDetailArray[indexPath.row]
        return cell!
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let urlString = recDetailArray[indexPath.row]
            
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
