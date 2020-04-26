

import UIKit
var onHome = true
var articles = [ArticleLitModel]()
var clicked = false
var vSpinner : UIView?
class HomeController: UIViewController {
    //MARK: - Properties
    var loadingData = true
    var tableView = UITableView()
    let cellSpacingHeight: CGFloat = 60
    var article: ArticleLitModel?
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
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @objc func loadList(notification: NSNotification){
         //load data here
         self.showSpinner(onView: view)
         print("got over here")
         onHome = true
         allNews.fetchArticles()
     }

    override func viewWillAppear(_ animated: Bool) {
            self.showSpinner(onView: view)
            allNews.fetchArticles()
            onHome = true
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             print("tappedbox")
         article = articles[indexPath.section]
          if let url = URL(string: article!.url!) {
              UIApplication.shared.open(url)
          } else {
              return
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell(style: .default, reuseIdentifier: K.newsCell)
        article = articles[indexPath.section]
        cell.set(article: article!)
        cell.selectionStyle = .none
        if indexPath.section == articles.count - 1 && !loadingData {
            loadingData = true
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(40), width: tableView.bounds.width, height: CGFloat(104))
            spinner.startAnimating()
            tableView.tableFooterView = spinner
            self.tableView.reloadData()
            offset = String(Int(offset!)! + 100)
            allNews.fetchArticles(update: true)
        }
        cell.configureBookmark()
        return cell
    }

}



extension HomeController: NewsManagerDelegate  {
    func didUpdateArticles() {
        DispatchQueue.main.async {
            //set delegates
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.view.addSubview(self.tableView)
            self.loadingData = false
            self.configureTableView(tableView: self.tableView)
            self.spinner.hidesWhenStopped = true
            self.spinner.stopAnimating()
            self.setUpMenuBar()
            self.tableView.reloadData()
        
        }
    }
}





