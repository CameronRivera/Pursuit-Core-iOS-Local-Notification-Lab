//
//  ManageTimersView.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/19/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class ManageTimersView: UIView {
    
    public lazy var timersTableView: UITableView = { 
       let tableView = UITableView()
        return tableView
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
        setUpTimersTableViewConstraints()
    }
    
    private func setUpTimersTableViewConstraints(){
        addSubview(timersTableView)
        timersTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timersTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), timersTableView.leadingAnchor.constraint(equalTo: leadingAnchor), timersTableView.trailingAnchor.constraint(equalTo: trailingAnchor), timersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
}
