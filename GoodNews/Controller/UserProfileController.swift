//
//  UserProfileController.swift
//  GoodNews
//
//  Created by Dante Kim on 4/16/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {
    //MARK: - Properties
    
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureUI()
    }
    //MARK: - Helper Functions
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }
    
    //MARK: - Handlers
}
