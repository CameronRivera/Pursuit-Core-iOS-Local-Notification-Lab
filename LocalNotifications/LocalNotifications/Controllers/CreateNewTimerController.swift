//
//  CreateNewTimerController.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/19/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

protocol CreateNewTimerControllerDelegate: AnyObject{
    func submitButtonPressed(_ createNewTimerController: CreateNewTimerController)
}

class CreateNewTimerController: UIViewController {

    private let timerView = CreateNewTimerView()
    
    public weak var delegate: CreateNewTimerControllerDelegate?
    
    private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 10
    
    override func loadView(){
        view = timerView
    }
    
    override func viewWillLayoutSubviews(){
        timerView.messageTextField.layer.borderWidth = 1.0
        timerView.messageTextField.layer.borderColor = UIColor.black.cgColor
        timerView.messageTextField.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Create New Timer Notification"
        timerView.datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        timerView.timerLaunchButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
    }
    
    private func reset(){
        DispatchQueue.main.async{
            self.timerView.datePicker.date = Date()
            self.timerView.messageTextField.text = ""
        }
    }
    
    private func createNewTimer(){
        // Step 1: Create Content
        let content = UNMutableNotificationContent()
        content.body = timerView.messageTextField.text ?? "No description provided"
        
        if timerView.messageTextField.text == "" {
            content.body = "No description provided"
        }
        
        // Step 2: Create an identifier
        let iD = UUID().uuidString
        
        // Step 3: Create an attachment (Optional Implementation)
        //let attachment = UNNotificationAttachment(identifier: iD, url: Bundle.main.path(forResource: "" , withExtension: ""), options: nil)
        
        // Step 4: Create a trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // Step 5: Create a request
        let request = UNNotificationRequest(identifier: iD, content: content, trigger: trigger)
        
        // Step 6: Add request to the Notification Center
        UNUserNotificationCenter.current().add(request) { [weak self] error in
            if let error = error {
                DispatchQueue.main.async{
                    self?.showAlert("Failed", "Could not create a new timer: \(error)")
                }
            } else {
                DispatchQueue.main.async{
                    self?.showAlert("Timer Created", "A new timer was successfully created.")
                    self?.delegate?.submitButtonPressed(self!)
                }
            }
        }
        
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker){
        guard sender.date > Date() else {
            return
        }
        timeInterval = sender.date.timeIntervalSinceNow
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton){
        createNewTimer()
        reset()
    }

}
