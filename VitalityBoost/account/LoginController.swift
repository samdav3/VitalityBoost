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
            //                Task{
            //                    await loginDBCheck()
            //                }
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
                //                    Task{
                //                        await checkDB()
                //                    }
                //                    if exists == true {
                //                        let updateAlert = UIAlertController(title: "Username already Exists", message: "Please use a different Username or Login to existing Account.", preferredStyle: .alert)
                //                        updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                //                        self.present(updateAlert, animated: true, completion: nil)
                //                        var perform = shouldPerformSegue(withIdentifier: "createAccount", sender: self)
                //                        perform.toggle()
                //                    }
                //                    else if exists == false{
                let createAccountVC = segue.destination as! CreateAccountController
                username = userUsername.text ?? ""
                createAccountVC.rcvdUsername = username
                createAccountVC.navigationItem.title = "Create Account"
                //                    }
            }
        }
    }
}
        
//        func checkDB() async {
//            do{
//                let document = try await db.collection("users").document(username).getDocument()
//                if(document.exists){
//                    exists = true
//                }
//                else{
//                    exists = false
//                    print("Error checking DB")
//                }
//            }
//            catch{
//                print("Error getting document: \(error)")
//            }
//        }
        
//        func loginDBCheck() async{
//            do{
//                let document = try await db.collection("users").document(username).getDocument()
//                let enteredPassword = userPassword.text
//                if (document.exists){
//                    let data = document.data()
//                    let password = data?["password"]
//                    if (enteredPassword == password as? String){
//                        func prepare(for segue: UIStoryboardSegue, for: Any?){
//                            let accountVC = segue.destination as! AccountController
//                            username = userUsername.text ?? ""
//                            accountVC.rcvdUsername = username
//                            accountVC.navigationItem.title = "Account"
//                        }
//                        
//                    }
//                    else if (enteredPassword != password as? String){
//                        func prepare(for segue: UIStoryboardSegue, for: Any?){
//                            let createAlert = UIAlertController(title: "Incorrect Password", message: "Please enter the correct Password for this Username.", preferredStyle: .alert)
//                            createAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//                            self.present(createAlert, animated: true, completion: nil)
//                            let loginVC = segue.destination as! LoginController
//                            username = userUsername.text ?? ""
//                            loginVC.rcvdUsername = username
//                            loginVC.navigationItem.title = "Login"
//                        }
//                        
//                    }
//                }
//                else{
//                    let createAlert = UIAlertController(title: "Problem Accessing User", message: "There was a problem accessing this Account, please try again.", preferredStyle: .alert)
//                    createAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//                    self.present(createAlert, animated: true, completion: nil)
//                }
//            }
//            catch{
//                print("Error getting document: \(error)")
//            }
//        }
        
    

//            if(userUsername.text! == ""){
//                let createAlert = UIAlertController(title: "Username Required", message: "Please enter the Username you would like to use for your Account.", preferredStyle: .alert)
//                    createAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//                    self.present(createAlert, animated: true, completion: nil)
//                }else{
//                    let createAccountVC = segue.destination as! CreateAccountController
//                    username = userUsername.text ?? ""
//                    createAccountVC.rcvdUsername = username
//                    createAccountVC.navigationItem.title = "Create Account"
//                }

//func action(){
//    var segue: UIStoryboardSegue
//    if segue.identifier == "login"{
//        Task{
//            await loginDBCheck()
//        }
//        //            let accountVC = segue.destination as! AccountController
//        //            username = userUsername.text ?? ""
//        //            accountVC.rcvdUsername = username
//        //            accountVC.navigationItem.title = "Account"
//    }else if segue.identifier == "createAccount"{
//        if (userUsername.text! == ""){
//            let createAlert = UIAlertController(title: "Username Required", message: "Please enter the Username you would like to use for your Account.", preferredStyle: .alert)
//            createAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
//            self.present(createAlert, animated: true, completion: nil)
//        }
//        else{
//            Task{
//                await checkDB()
//            }
//        }
//    }
