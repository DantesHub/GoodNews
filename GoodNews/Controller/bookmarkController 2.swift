//
//  SavedController.swift
//  GoodNews
//
//  Created by Dante Kim on 4/16/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit
import RealmSwift

class BookmarkController: UIViewController {
    //MARK: - Properties
    var tableView = UITableView()
    var results: Results<SavedArticle>!
    var articles: Array<ArticleModel> = [ArticleModel]()
    let cellSpacingHeight: CGFloat = 30
    
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
         loadArticles()
    }
    
    //MARK: - Helper Functions
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Saved"
        navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.configureTableView(tableView: self.tableView)
    }
    
    func loadArticles() {
        results = uiRealm.objects(SavedArticle.self)
        var article = ArticleModel()
        for result in results {
            article.url = result.value(forKey: "url") as! String?
            article.title = result.value(forKey: "title") as! String?
            article.description = result.value(forKey: "desc") as! String?
            article.urlImage = result.value(forKey: "urlImage") as! String?
            article.publishedAt = result.value(forKey: "publishedAt") as! String?
            articles.append(article)
        }
    }

}

//MARK: - extensions
extension BookmarkController: UITableViewDelegate, UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.newsCell) as! NewsCell
        let article = articles[indexPath.section]
        cell.set(article: article)
        cell.configureBookmark()
        cell.selectionStyle = .none
        
        return cell
    }
}
