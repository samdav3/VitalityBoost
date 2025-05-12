//
//  SupplementsController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SafariServices

class SupplementsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var rcvdUsername = ""
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let suppTableArray = ["AG1 Greens Powder Supplement", "Bloom Nutrition Greens Superfoods Powder", "OLLY Metabolism Gummy Rings Apple Cider Vinegar", "BodyHealth Perfect Amino", "Lion's Mane Mushroom Supplement", "Standardized Turmeric Curcumin Complex with Black Pepper", "Tropical Kefir", "Peak Metabolism", "Revive Calm", "Relax & Restore", "Emotional Wellness"]
    let suppDescArray = ["A greens powder that provides vitamins, minerals, and probiotics to support overall health and digestion.", "A budget-friendly greens supplement that supports digestion, immunity, and energy levels.", "Gummy supplements infused with apple cider vinegar to support metabolism and energy production.", "A blend of essential amino acids that supports muscle growth, recovery, and overall health. Highly rated by users for its effectiveness.", "Lion's Mane is renowned for its neuroprotective properties, supporting mental clarity and cognitive function. It's ideal for those looking to enhance focus and memory.", "Turmeric, combined with black pepper for enhanced absorption, offers powerful anti-inflammatory benefits, aiding joint health and overall vitality.", "This probiotic-rich beverage supports digestive health and boosts the immune system, making it a tasty addition to your wellness routine.", "Formulated to assist in maintaining healthy blood sugar levels and metabolism, this supplement is beneficial for energy regulation.", "Designed to promote relaxation and reduce stress, Revive Calm supports emotional well-being and mental clarity.", "This formula combines magnesium, GABA, and L-theanine to support mood stability and restful sleep.", "Containing 5-HTP and L-tyrosine, this supplement aids in the synthesis of neurotransmitters, supporting emotional balance and cognitive function."]
    let suppDetailArray = ["https://drinkag1.com/shop/greens-powder-travel-pack", "https://bloomnu.com/products/greens-superfoods?variant=32499602784356", "https://www.olly.com/products/metabolism-gummy-rings?variant=41331985612875", "https://bodyhealth.com//products/perfectamino?variant=20006544048221", "https://doublewoodsupplements.com/products/lions-mane-mushroom?variant=44436006273218&_gsid=cLdweWo8xUB2", "https://pipingrock.com/products/standardized-turmeric-curcumin-complex-w-black-pepper-1000-mg-180-quick-release-capsules-2912?variant=43261349331182&_gsid=sEH4wGNfJeLR", "https://drinklavie.shop/products/tropical-kefir-12oz?variant=1063219443&_gsid=Yp2tAiuoDEfT", "https://www.twc.health/products/blood-sugar-formula?variant=43170368389336&_gsid=wphRGGWWFiTA", "https://nutritionfaktory.com/products/calm-180caps?variant=36920561205413&_gsid=wphRGGWWFiTA", "https://shopwellnessatcenturycity.com/products/relax-restore-120c?variant=45051404812466&_gsid=wphRGGWWFiTA", "https://shop.nuesana.com/products/emotional-wellness?variant=45346372747560&_gsid=wphRGGWWFiTA"]
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
        return suppTableArray.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID
            )
        }
        cell?.textLabel?.text = suppTableArray[indexPath.row]
        cell?.detailTextLabel?.text = suppDescArray[indexPath.row]
        return cell!
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let urlString = suppDetailArray[indexPath.row]
            
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
