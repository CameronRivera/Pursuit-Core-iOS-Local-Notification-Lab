//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/19/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    private let manageTimersView = ManageTimersView()
    private var timersArr: [UNNotificationRequest] = [] {
        didSet{
            DispatchQueue.main.async{
                self.manageTimersView.timersTableView.reloadData()
            }
        }
    }
    
    private var refreshController: UIRefreshControl!
    private let pendingNotification: PendingNotification = PendingNotification()
    private let current = UNUserNotificationCenter.current()
    
    override func loadView(){
        view = manageTimersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Manage Created Timers"
        refreshControl()
        current.delegate = self
        checkNotificationPermissionStatus()
        setUp()
    }
    
    private func setUp(){
        manageTimersView.timersTableView.dataSource = self
        manageTimersView.timersTableView.register(TimerCell.self, forCellReuseIdentifier: "timerCell")
        loadTimers()
    }
    
    private func checkNotificationPermissionStatus(){
        current.getNotificationSettings { [weak self] settings in
            if settings.authorizationStatus == .authorized{
            } else {
                self?.requestNotificationPermission()
            }
        }
    }
    
    private func requestNotificationPermission(){
        current.requestAuthorization(options: [.alert, .sound]) { granted,error in
            if let error = error {
                print("Error requesting authorization: \(error)")
            }
            
            if granted {
                print("Access granted")
            } else {
                print("Access denied")
            }
        }
    }
    
    private func refreshControl(){
        refreshController = UIRefreshControl()
        manageTimersView.timersTableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(loadTimers), for: .valueChanged)
    }
    
    @objc
    private func loadTimers(){
        pendingNotification.getPendingNotification { [weak self] request in
            self?.timersArr = request
            DispatchQueue.main.async{
                self?.refreshController.endRefreshing()
            }
        }
    }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "timerCell", for: indexPath) as? TimerCell else {
            fatalError("Could not dequeue cell as a TimerCell.")
        }
        xCell.configureCell(timersArr[indexPath.row])
        return xCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            removeRow(indexPath)
        }
    }
    
    private func removeRow(_ indexPath: IndexPath){
        current.removePendingNotificationRequests(withIdentifiers: [timersArr[indexPath.row].identifier])
        
        timersArr.remove(at: indexPath.row)
        
        manageTimersView.timersTableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension ViewController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}

extension ViewController: CreateNewTimerControllerDelegate{
    func submitButtonPressed(_ createNewTimerController: CreateNewTimerController) {
        loadTimers()
    }
}

