//
//  BaseTabBarController.swift
//  VitalityBoost
//
//  Created by Sam on 4/17/25.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var rcvdUsername = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func prepare(for segue: UITabBarItem, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.title == "Home"{
            let homeVC = ViewController()
            homeVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Account"{
            let accountVC = AccountController()
            accountVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Fitness"{
            let fitnessVC = FitnessController()
            fitnessVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Workouts"{
            let workoutsVC = WorkoutsController()
            workoutsVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Recipes"{
            let recipesVC = RecipesController()
            recipesVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Calendar"{
            let calendarVC = CalendarController()
            calendarVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Journal"{
            let journalVC = JournalController()
            journalVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Affordable Options"{
            let affordableVC = AffordableOptionsController()
            affordableVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Explore"{
            let personalVC = PersonalResearchController()
            personalVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Supplements"{
            let supplementsVC = SupplementsController()
            supplementsVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Recipe Search"{
            let recipeSearchVC = RecipesSearchController()
            recipeSearchVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Organization Assistance"{
            let organizationVC = OrganizationAssistanceController()
            organizationVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Journal Entries"{
            let journalEntryVC = JournalEntriesController()
            journalEntryVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Mental Health Resources"{
            let mentalHealthVC = MentalHealthResourcesController()
            mentalHealthVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Account Info"{
            let accountVC = AccountController()
            accountVC.rcvdUsername = rcvdUsername
        }
        else if segue.title == "Goals"{
            let goalsVC = GoalsController()
            goalsVC.rcvdUsername = rcvdUsername
        }
     
    }
    

}
