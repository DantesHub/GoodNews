//
//  SettingsController.swift
//  GoodNews
//
//  Created by Dante Kim on 4/26/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    let smileyImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "smileyFace")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let loggedInLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Logged In!"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "GillSans-Bold", size: 30)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 30)!]
        //        UINavigationBar.appearance().shadowImage = UIImage()
        //        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true;
        navigationItem.leftBarButtonItem = nil
        
        view.addSubview(loggedInLabel)
        view.addSubview(smileyImage)
        
        loggedInLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        loggedInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        loggedInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        smileyImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        smileyImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        smileyImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
       

    }
}
