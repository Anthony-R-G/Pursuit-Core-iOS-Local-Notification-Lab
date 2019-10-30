//
//  ManageViewController.swift
//  LocalNotifications
//
//  Created by Anthony Gonzalez on 10/29/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

class ManageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print(request)
            }
        })

    }
}
