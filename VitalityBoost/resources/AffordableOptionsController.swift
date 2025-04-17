//
//  AffordableOptionsController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import SwiftUI
import SafariServices

class AffordableOptionsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    init(
//        url URL: URL,
//        configuration: SFSafariViewController.Configuration
//    ){
//        struct SFSafariViewWrapper: UIViewControllerRepresentable {
//            let url: URL
//            
//            func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
//                return SFSafariViewController(url: url)
//            }
//            
//            func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
//                return
//            }
//        }
//        super.init(coder: NSCoder())!
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    @State private var showSafari: Bool = false
    
    var rcvdUsername = ""
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var table: UITableView!
    let affTitleArray = ["Free At Home Workouts", "Better Me", "Apple Fitness", "DAREBEE", "Planet Fitness", "The Edge Fitness Clubs", "MadFit YouTube Channel", "Tone & Tighten YouTube Channel", "growingannanas YouTube Channel", "Aldi", "Trader Joe's"]
    let affDetailArray = ["https://www.muscleandstrength.com/workouts/home", "https://betterme.world/", "https://www.apple.com/apple-fitness-plus/", "https://darebee.com/workouts.html", "https://www.planetfitness.com/", "https://www.theedgefitnessclubs.com/", "https://www.youtube.com/@MadFit", "https://www.youtube.com/@toneandtighten", "https://www.youtube.com/@growingannanas", "https://www.aldi.com/", "https://www.traderjoes.com/home"]
    // add healthy food options that are cheap
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
        return affTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil){
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.subtitle,
                reuseIdentifier: cellID
            )
        }
        cell?.textLabel?.text = affTitleArray[indexPath.row]
        cell?.detailTextLabel?.text = affDetailArray[indexPath.row]
        return cell!
        
        
    }
    
    
    
    private func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        let selectedRow = tableView.indexPathForSelectedRow
        let link = affDetailArray[indexPath.row]
        //        let url = URL(string: link)!
        if URL(string: link) != nil{
            //            UIApplication.shared.open(url)
            let safariController = SFSafariViewController(url: URL(string: link)!)
            present(safariController, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
        
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
//        switch indexPath.section{
//        case 0:
//            switch indexPath.row{
//            case 0:
                
//                if let url = URL(string: link){
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.muscleandstrength.com/workouts/home")!)
                //                })
                //                case 1:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://betterme.world/")!)
                //                })
                //                case 2:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.apple.com/apple-fitness-plus/")!)
                //                })
                //                case 3:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://darebee.com/workouts.html")!)
                //                })
                //                case 4:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.planetfitness.com/")!)
                //                })
                //                case 5:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.theedgefitnessclubs.com/")!)
                //                })
                //                case 6:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.youtube.com/@MadFit")!)
                //                })
                //                case 7:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.youtube.com/@toneandtighten")!)
                //                })
                //                case 8:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.youtube.com/@growingannanas")!)
                //                })
                //                case 9:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.aldi.com/")!)
                //                })
                //                case 10:
                //                selectedRow.onTapGesture(count: 1, perform: showSafari.toggle()).fullScreenCover(isPresented: $showSafari, content: {SFSafariViewWrapper(url: URL("https://www.traderjoes.com/home")!)
                //                })
//            default:
//                return
//            }
//        default:
//            return
//        }
//        
//        
//    }

    
    
    
//    private func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        init(
//            url URL: URL,
//            configuration: SFSafariViewController.Configuration
//        )
//        let link = affDetailArray[indexPath.row]
//        
//                switch indexPath.section {
//                case 0:
//                    if let url = URL(string: link) {
//                        UIApplication.shared.open(url as URL)
//                        let safariController = SFSafariViewController(url: url)
//                        present(safariController, animated: true, completion: nil)
//                    }
////                case 1:
////                    if let url = URL(string: link) {
////                        let safariController = SFSafariViewController(url: url)
////                        present(safariController, animated: true, completion: nil)
////                    }
//        
//                 default:
//                     break
//                 }
//        
//                tableView.deselectRow(at: indexPath as IndexPath, animated: false)
//    }
    
//    func open(_ url: URL,
//              options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:],
//              completionHandler completion: (@MainActor (Bool) -> Void)? = nil){
//        
//        
//    }

//
//     
//        let url : NSURL?
//
//        switch indexPath.section{
//        case 0:
//            switch indexPath.row{
//            case 0:
//                url = NSURL(string: "https://www.muscleandstrength.com/workouts/home")
//            case 1:
//                url = NSURL(string: "https://betterme.world/")
//            case 2:
//                url = NSURL(string: "https://www.apple.com/apple-fitness-plus/")
//            case 3:
//                url = NSURL(string: "https://darebee.com/workouts.html")
//            case 4:
//                url = NSURL(string: "https://www.planetfitness.com/")
//            case 5:
//                url = NSURL(string: "https://www.theedgefitnessclubs.com/")
//            case 6:
//                url = NSURL(string: "https://www.youtube.com/@MadFit")
//            case 7:
//                url = NSURL(string: "https://www.youtube.com/@toneandtighten")
//            case 8:
//                url = NSURL(string: "https://www.youtube.com/@growingannanas")
//            case 9:
//                url = NSURL(string: "https://www.aldi.com/")
//            case 10:
//                url = UIApplication.sharedApplication.openURL(NSURL(string: "https://www.traderjoes.com/home")! as URL)
//            default:
//                return;
//            }
//        case 1:
//            switch indexPath.row{
//            case 0:
//                url = NSURL(string: "http://section1.row0.com")
//            case 1:
//                url = NSURL(string: "http://section1.row1.com")
//            default:
//                return;
//            }
//        default:
//            return;
//        }
//
//        if url != nil{
////            UIApplication.shared.openURL(url! as URL)
//            UIApplication.shared.canOpenURL(url! as URL)
//        }
    
//    struct OpenURLExample: TableRowContent {
//        @Environment(\.openURL) private var openURL
//
//
//        var body: some View {
//            Button {
//                if let url = URL(string: "https://www.example.com") {
//                    openURL(url)
//                }
//            } label: {
//                Label("Get Help", systemImage: "person.fill.questionmark")
//            }
//        }
//    }
        
    
