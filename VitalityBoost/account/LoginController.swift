//
//  LoginController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import FirebaseDatabaseInternal
import SwiftUI

class LoginController: UIViewController {
    
    let db = Firestore.firestore()
    var rcvdUsername = ""
    var exists: Bool = false
    @IBOutlet weak var userUsername: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        print(rcvdUsername)
        userUsername.text = username
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "login"{
            let accountVC = segue.destination as! AccountController
            username = userUsername.text ?? ""
            accountVC.rcvdUsername = username
            accountVC.navigationItem.title = "Account"
        }else if segue.identifier == "createAccount"{
            if (userUsername.text! == ""){
                let createAlert = UIAlertController(title: "Username Required", message: "Please enter the Username you would like to use for your Account.", preferredStyle: .alert)
                createAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(createAlert, animated: true, completion: nil)
            }
            else{
                let createAccountVC = segue.destination as! CreateAccountController
                username = userUsername.text ?? ""
                createAccountVC.rcvdUsername = username
                createAccountVC.navigationItem.title = "Create Account"
            }
        }
    }
}
        

