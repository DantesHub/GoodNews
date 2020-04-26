//
//  SettingsController.swift
//  GoodNews
//
//  Created by Dante Kim on 4/26/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit
import RealmSwift

class SettingsController: UIViewController {
    var results: Results<User>!
    let smileyImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "smileyFace")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let logOutButton = UIButton()
    let loggedInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Logged In!"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "GillSans-Bold", size: 40)
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
        navigationController?.navigationBar.isHidden = true
        
        
        view.addSubview(loggedInLabel)
        view.addSubview(smileyImage)
        loggedInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        loggedInLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        loggedInLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        smileyImage.topAnchor.constraint(equalTo: loggedInLabel.bottomAnchor, constant: 40).isActive = true
        smileyImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        smileyImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        smileyImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
        
        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.titleLabel?.font = UIFont(name: "Menlo-Bold", size: 20)
        logOutButton.titleLabel?.textAlignment = .center
        logOutButton.layer.cornerRadius = 25
        logOutButton.backgroundColor = darkRed
        logOutButton.layoutSubviews()
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        logOutButton.topAnchor.constraint(equalTo: smileyImage.bottomAnchor, constant: 0).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logOutButton.addTarget(self, action: #selector(logOutPressed), for: .touchUpInside)
    }
    @objc func logOutPressed() {
        print("Pressed")
        results = uiRealm.objects(User.self)
        for result  in results {
            if result.isLoggedIn == true {
                do {
                    try uiRealm.write {
                        result.setValue(false, forKey: "isLoggedIn")
                        loggedOut = true
                        let userProfileController = UserProfileController()
                        userProfileController.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(userProfileController, animated: false)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
