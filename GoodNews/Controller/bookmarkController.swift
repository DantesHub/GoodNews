

import UIKit
import RealmSwift
import Firebase

class BookmarkController: UIViewController {
    //MARK: - Properties
    var tableView = UITableView()
    var userResults: Results<User>!
    var results: Results<SavedArticle>!
    var articlez: Array<ArticleLitModel> = [ArticleLitModel]()
    let db = Firestore.firestore()
    let cellSpacingHeight: CGFloat = 50
    var newsCell = NewsCell()
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        onHome = false
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
         loadArticles()
         userResults = uiRealm.objects(User.self)
          for result in userResults {
              if result.isLoggedIn == true {
                configureUI()
                configureNavBar()
                return
              }
          }
        configureNavBar()
        view.backgroundColor = .lightGray
        let middleLabel = UILabel()
        middleLabel.translatesAutoresizingMaskIntoConstraints = false
        middleLabel.numberOfLines = 2
        middleLabel.text = "Must be logged in \nto save articles!"
        middleLabel.textColor = .white
        middleLabel.font = UIFont(name: "Menlo-Bold", size: 30)
        view.addSubview(middleLabel)
        middleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        middleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

         
    }
    @objc func loadList(notification: NSNotification){
        //load data here
        loadArticles()
        self.tableView.reloadData()
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
        var article = ArticleLitModel()
        for result in results {
            let bookmarked = result.value(forKey: "isBookmarked") as! Bool
            article.url = result.value(forKey: "url") as! String?
            article.title = result.value(forKey: "title") as! String?
            article.description = result.value(forKey: "desc") as! String?
            article.urlImage = result.value(forKey: "urlImage") as! String?
            article.publishedAt = result.value(forKey: "publishedAt") as! String?
            if !articlez.contains(article) && bookmarked == true  {
                articlez.append(article)
            }
        }
    }
}

//MARK: - extensions
extension BookmarkController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return articlez.count
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
        let article = articlez[indexPath.section]
        cell.set(article: article)
        cell.selectionStyle = .none
        cell.configureBookmark()
        return cell
    }
}


