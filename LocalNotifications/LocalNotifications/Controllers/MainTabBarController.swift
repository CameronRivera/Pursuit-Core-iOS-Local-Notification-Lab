//
//  MainTabBarController.swift
//  LocalNotifications
//
//  Created by Cameron Rivera on 2/19/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    public lazy var timerViewController: CreateNewTimerController = {
        let vc = CreateNewTimerController()
        vc.tabBarItem = UITabBarItem(title: "Create Timer", image: UIImage(systemName:"clock"), tag: 0)
        return vc
    }()
    
    public lazy var manageTimersViewController: ViewController = {
        let vc = ViewController()
        vc.tabBarItem = UITabBarItem(title: "Manage Timers", image: UIImage(systemName: "pencil"), tag: 1)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerViewController.delegate = manageTimersViewController
        viewControllers = [UINavigationController(rootViewController: manageTimersViewController), UINavigationController(rootViewController: timerViewController)]
    }
}
