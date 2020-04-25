//
//  HomeController.swift
//  GoodNews
//
//  Created by Dante Kim on 4/16/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit

var articles: Array<ArticleLitModel> = [ArticleLitModel]()
var vSpinner : UIView?
class HomeController: UIViewController {
    //MARK: - Properties
    var loadingData = true
    var tableView = UITableView()
    let cellSpacingHeight: CGFloat = 80
    let spinner = UIActivityIndicatorView(style: .gray)
    var allNews = NewsManager()
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        allNews.delegate = self
        configureUI()
    }

    
    override func viewWillAppear(_ animated: Bool) {
         self.showSpinner(onView: view)
         allNews.fetchArticles()
     }
     
    //MARK: - Helper functions
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "News"
        configureNavBar()
    }
    
    private func setUpMenuBar() {
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

//MARK: - TableView
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }

    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
    
    // Make the background color show through
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell(style: .default, reuseIdentifier: K.newsCell)
        let article = articles[indexPath.section]
        cell.set(article: article)
        cell.selectionStyle = .none
        cell.configureBookmark()
        if indexPath.section == articles.count - 1 && !loadingData {
            loadingData = true
            spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 70)
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            self.tableView.reloadData()
            count = String(Int(count!)! + 10)
            offset = String(Int(offset!)! + 10)
            allNews.fetchArticles(update: true)
        }
        return cell
    }
}



extension HomeController: NewsManagerDelegate  {
    func didUpdateArticles() {
        DispatchQueue.main.async {
            //set delegates
            self.loadingData = false
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.view.addSubview(self.tableView)
            self.configureTableView(tableView: self.tableView)
            self.removeSpinner()
            self.spinner.hidesWhenStopped = true
            self.spinner.stopAnimating()
            self.setUpMenuBar()
        }
    }
}





