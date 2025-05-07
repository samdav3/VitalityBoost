//
//  CreateAccountController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseAppCheck
import CoreMedia

class CreateAccountController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var userUsername: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userFirstName: UITextField!
    @IBOutlet weak var userLastName: UITextField!
    @IBOutlet weak var userEmailT: UITextField!
    @IBOutlet weak var userPhone: UITextField!
    @IBOutlet weak var userAddress: UITextField!
    @IBOutlet weak var createAcctBtn: UIButton!
    
    var username = ""
    public var rcvdUsername = ""
    var userUsernameEntry = ""
    var userPasswordEntry = ""
    var userFirstNameEntry = ""
    var userLastNameEntry = ""
    var userEmaiLEntry = ""
    var userPhoneEntry = ""
    var userAddressEntry = ""
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        userUsername.text! = rcvdUsername
        Task{
            await checkDB()
        }
    }
    
    func checkDB() async{
        do{
            let document = try await db.collection("users").document(rcvdUsername).getDocument()
            if(document.exists){
                
                let updateAlert = UIAlertController(title: "Username already Exists", message: "Please use a different Username or Login to existing Account.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in 
                    self.navigationController?.popViewController(animated: true)
                    
                }))
                self.present(updateAlert, animated: true, completion: nil)
            }else{
                print("Error checking DB")
            }
        }
        catch{
            print("Error getting document: \(error)")
        }
    }
    
    @IBAction func createAccountBtn(_ sender: UIButton) {
        Task {
            await createAccount()
        }

    }
    
    
    func createAccount() async {
        do{
            if userUsername.text == "" {
                let updateAlert = UIAlertController(title: "Username is Required", message: "Please enter a Username to create your Account.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(updateAlert, animated: true, completion: nil)
            }
            else if userPassword.text == "" {
                let updateAlert = UIAlertController(title: "Password is Required", message: "Please enter a Password to create your Account.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(updateAlert, animated: true, completion: nil)
            }
            else if userEmailT.text == "" {
                let updateAlert = UIAlertController(title: "Email is Required", message: "Please enter a, Email to create your Account.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(updateAlert, animated: true, completion: nil)
            }
            else if userFirstName.text == "" {
                let updateAlert = UIAlertController(title: "First Name is Required", message: "Please enter your First Name to create your Account.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(updateAlert, animated: true, completion: nil)
            }
            else {
                _ = try await db.collection("users").document(userUsername.text!).setData([
                    "username": userUsername.text!,
                    "password": userPassword.text!,
                    "firstName": userFirstName.text!,
                    "lastName": userLastName.text!,
                    "email": userEmailT.text!,
                    "phone": userPhone.text!,
                    "address": userAddress.text!,
                ])
                
                let docID = db.collection("users").document(userUsername.text!).documentID
                print("Document added/updated with ID: \(docID)")
                let updateAlert = UIAlertController(title: "Welcome \(userFirstName.text!)!", message: "Your Account has been Created. Visit the Account Page to View or Update your Account Information.", preferredStyle: .alert)
                updateAlert.addAction(UIAlertAction(title: "Go To Account", style: .default, handler: {_ in
                    let controller = AccountController.fromStoryboard()
                    controller.rcvdUsername = self.userUsername.text!
                    self.navigationController?.pushViewController(controller, animated: true)
                }))
                self.present(updateAlert, animated: true, completion: nil)
            }
            
        }
        catch {
            print("Error adding document: \(error)")
            
        }
    }
    
}
