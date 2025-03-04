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
    }

}

