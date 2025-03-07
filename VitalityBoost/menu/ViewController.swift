//
//  ViewController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    }
    
    

}

