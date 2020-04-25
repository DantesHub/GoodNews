//
//  Extensions.swift
//  GoodNews
//
//  Created by Dante Kim on 4/19/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension UIViewController {
    func configureTableView(tableView: UITableView) {
         //set row height
         tableView.rowHeight = 400
         //register cells
         tableView.register(NewsCell.self, forCellReuseIdentifier: K.newsCell)
         //set constraints
         tableView.pin(to:view)
         tableView.separatorStyle = .none
     }
}

extension UIViewController {
    func configureNavBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 30)!]
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = false;
    }
}

extension UIView {
    func pin(to view: UIView) {
           translatesAutoresizingMaskIntoConstraints = false
           topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
           bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

