//
//  CalendarController.swift
//  VitalityBoost
//
//  Created by Sam on 3/2/25.
//

import UIKit
import EventKit
import EventKitUI
import FSCalendar

class CalendarController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource, EKEventEditViewDelegate {
    
    var rcvdUsername = ""
    
    let calendarView = FSCalendar()
    let tableView = UITableView()
    let addButton = UIButton(type: .system)
    
    let eventStore = EKEventStore()
    var events: [EKEvent] = []
    var selectedDate: Date = Date()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(rcvdUsername)
        
        setupCalendar()
        setupTableView()
        setupAddButton()
                
        requestCalendarAccess()

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
    
    func setupCalendar() {
            calendarView.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: 420)
            calendarView.delegate = self
            calendarView.dataSource = self
            view.addSubview(calendarView)
        }
        
        func setupTableView() {
            tableView.frame = CGRect(x: 0, y: 565, width: view.frame.width, height: view.frame.height - 450)
            tableView.delegate = self
            tableView.dataSource = self
            view.addSubview(tableView)
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        
        let eventViewController = EKEventViewController()
        eventViewController.event = event
        eventViewController.allowsEditing = true   // Allow user to edit!
        eventViewController.allowsCalendarPreview = true
        eventViewController.delegate = self
        
        let navController = UINavigationController(rootViewController: eventViewController)
        present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            
            let eventToDelete = self.events[indexPath.row]
            
            do {
                try self.eventStore.remove(eventToDelete, span: .thisEvent)
                self.events.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                completionHandler(true)
            } catch {
                print("Failed to delete event: \(error.localizedDescription)")
                completionHandler(false)
            }
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
        
        func setupAddButton() {
            addButton.frame = CGRect(x: 20, y: 520, width: view.frame.width - 40, height: 40)
            addButton.setTitle("➕ Add Event", for: .normal)
            addButton.backgroundColor = .systemBlue
            addButton.setTitleColor(.white, for: .normal)
            addButton.layer.cornerRadius = 8
            addButton.addTarget(self, action: #selector(addEventTapped), for: .touchUpInside)
            view.addSubview(addButton)
        }
        
        func requestCalendarAccess() {
            eventStore.requestFullAccessToEvents() { (granted, error) in
            //requestAccess(to: .event) { (granted, error) in
                if granted {
                    self.fetchEvents(for: self.selectedDate)
                } else {
                    print("Calendar access denied.")
                }
            }
        }
        
        func fetchEvents(for date: Date) {
            let calendars = eventStore.calendars(for: .event)
            let startOfDay = Calendar.current.startOfDay(for: date)
            let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
            
            let predicate = eventStore.predicateForEvents(withStart: startOfDay, end: endOfDay, calendars: calendars)
            self.events = eventStore.events(matching: predicate)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        @objc func addEventTapped() {
            let eventVC = EKEventEditViewController()
            eventVC.eventStore = eventStore
            
            let newEvent = EKEvent(eventStore: eventStore)
            newEvent.startDate = selectedDate
            newEvent.endDate = selectedDate.addingTimeInterval(3600) // 1-hour event
            eventVC.event = newEvent
            
            eventVC.editViewDelegate = self
            present(eventVC, animated: true, completion: nil)
        }
        
        // MARK: - FSCalendar Delegate
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            selectedDate = date
            fetchEvents(for: date)
        }
        
        // MARK: - TableView DataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return events.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let event = events[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = event.title
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            cell.detailTextLabel?.text = formatter.string(from: event.startDate)
            
            return cell
        }
        
        // MARK: - EKEventEditViewDelegate
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            controller.dismiss(animated: true) {
                self.fetchEvents(for: self.selectedDate)
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

extension CalendarController: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true) {
            self.fetchEvents(for: self.selectedDate)
        }
    }
}
