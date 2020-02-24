//
//  CreateNewTimerView.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/19/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class CreateNewTimerView: UIView {

    public lazy var datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.countDownDuration = 60
        return datePicker
    }()
    
    public lazy var messageTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "  Insert message here"
        textField.autocapitalizationType = .sentences
        return textField
    }()
    
    public lazy var timerLaunchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Launch", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpDatePickerConstraints()
        setUpTextFieldConstraints()
        setUpLaunchButtonConstraints()
    }
    
    private func setUpDatePickerConstraints() {
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([datePicker.centerYAnchor.constraint(equalTo: centerYAnchor), datePicker.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setUpTextFieldConstraints() {
        addSubview(messageTextField)
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([messageTextField.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -20), messageTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), messageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), messageTextField.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpLaunchButtonConstraints() {
        addSubview(timerLaunchButton)
        timerLaunchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timerLaunchButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20), timerLaunchButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }

}
