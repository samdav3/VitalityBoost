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
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> LoginController {
        let controller = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        print(rcvdUsername)
        userUsername.text = username
        
    }
    
    func loginCheck() async {
        do{
            let user = try await db.collection("users").document(userUsername.text!).getDocument()
            let password = user.get("password")
            if password as! String == userPassword.text!{
                let controller = AccountController.fromStoryboard()
                controller.rcvdUsername = self.userUsername.text!
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else{
                let updateAlert = UIAlertController(title: "Incorrect Password", message: "The Password you entered is incorrect. Please try again.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(updateAlert, animated: true, completion: nil)
                userPassword.text = ""
            }
        }
        catch{
            print("Error checking DB")
        }
    }
    @IBAction func login(_ sender: Any) {
        Task {
            await loginCheck()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "login"{
//            let accountVC = segue.destination as! AccountController
//            username = userUsername.text ?? ""
//            accountVC.rcvdUsername = username
//            accountVC.navigationItem.title = "Account"
//        }else
        if segue.identifier == "createAccount"{
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
        

