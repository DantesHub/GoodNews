<<<<<<< HEAD

import UIKit
import RealmSwift

class UserProfileController: UIViewController {
    //MARK: - Properties
    var loginView = UIView()
    var registerView = UIView()
    var loginLabel = UILabel()
    var registerLabel = UILabel()
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let middleText = UILabel()
    var results: Results<User>!
    
    
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        onHome = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 30)!]
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true;

        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true) //SHow

        print("welcome screen")
        results = uiRealm.objects(User.self)
        for result in results {
            if result.isLoggedIn == true {
                navigationController?.pushViewController(SettingsController(), animated: false)
            }
        }
    }
    //MARK: - Helper Functions
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        loadComponents()
    }
    
    //MARK: - Handlers
    func loadComponents() {
        view.backgroundColor = .white
        titleLabel1.frame.size.width = 300
        titleLabel1.frame.size.height = 100
        titleLabel1.center.x = view.center.x
        titleLabel1.center.y = view.center.y - 200
        titleLabel1.text = "GOOD"
        titleLabel1.font = UIFont(name: "Menlo", size: 55)
        titleLabel1.textColor = goldYellow
        
        titleLabel2.frame.size.width = 300
        titleLabel2.frame.size.height = 100
        titleLabel2.center.x = view.center.x + 145
        titleLabel2.center.y = view.center.y - 200
        titleLabel2.text = "NEWS!"
        titleLabel2.font = UIFont(name: "Menlo", size: 55)
        titleLabel2.textColor = goldYellow
        
        middleText.frame.size.width = 300
        middleText.frame.size.height = 400
        middleText.center.x = view.center.x
        middleText.center.y = view.center.y - 50
        middleText.text = "Do you want the good news or the good news first?"
        middleText.numberOfLines = 0;
        middleText.font = UIFont(name: "Hiragino Sans", size: 40)
        
        registerView =  UIView(frame: CGRect(x: 100, y: 400, width: 350, height: 80))
        registerView.applyDesign(color: bookmarkRed)
        registerView.center.x = view.center.x
        registerView.center.y = view.center.y + 250
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedRegister))
        registerView.addGestureRecognizer(tap)
        
        loginView =  UIView(frame: CGRect(x: 100, y: 400, width: 350, height: 80))
        loginView.applyDesign(color: twitterBlue)
        loginView.center.x = view.center.x
        loginView.center.y = view.center.y + 140
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tappedLogin))
        loginView.addGestureRecognizer(tap2)
        
        registerLabel.applyDesign(text: "Register")
        registerLabel.sizeToFit()
        registerLabel.center.x = view.center.x
        registerLabel.center.y = view.center.y + 250
        
        
        loginLabel.applyDesign(text: "Login")
        loginLabel.sizeToFit()
        loginLabel.center.x = view.center.x
        loginLabel.center.y = view.center.y + 140
        
        
        view.addSubview(titleLabel1)
        view.addSubview(titleLabel2)
        view.addSubview(loginView)
        view.addSubview(registerView)
        view.addSubview(loginLabel)
        view.addSubview(registerLabel)
        view.addSubview(middleText)
    }
    
    
    //MARK: - Handlers
    @objc func tappedLogin() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: false)
    }

    @objc func tappedRegister() {
        print("tapped")
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: false)
    }
}


=======
//import UIKit
//
//class UserProfileController: UIViewController {
//    //MARK: - Properties
//    var loginView = UIView()
//    var registerView = UIView()
//    var loginLabel = UILabel()
//    var registerLabel = UILabel()
//    let titleLabel1 = UILabel()
//    let titleLabel2 = UILabel()
//    let middleText = UILabel()
//
//    //MARK: - INIT
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    onHome = false
//        navigationController?.navigationBar.backgroundColor = .white
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.barTintColor = .white
//    navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.titleTextAttributes =
//            [NSAttributedString.Key.foregroundColor: UIColor.black,
//                 NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 30)!]
////        UINavigationBar.appearance().shadowImage = UIImage()
////        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.isTranslucent = true;
//
//        configureUI()
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//    self.navigationController?.setNavigationBarHidden(false, animated: true) //SHow
//    }
//    //MARK: - Helper Functions
//    func configureUI() {
//        view.backgroundColor = .white
//    navigationController?.navigationBar.prefersLargeTitles = true
//    navigationItem.title = "Settings"
//    loadComponents()
//    }
//
//    //MARK: - Handlers
//    func loadComponents() {
//        view.backgroundColor = .white
//    titleLabel1.frame.size.width = 300
//        titleLabel1.frame.size.height = 100
//    titleLabel1.center.x = view.center.x
//        titleLabel1.center.y = view.center.y - 200
//    titleLabel1.text = "GOOD"
//        titleLabel1.font = UIFont(name: "Menlo", size: 55)
//        titleLabel1.textColor = goldYellow
//
//    titleLabel2.frame.size.width = 300
//        titleLabel2.frame.size.height = 100
//    titleLabel2.center.x = view.center.x + 145
//        titleLabel2.center.y = view.center.y - 200
//    titleLabel2.text = "NEWS!"
//        titleLabel2.font = UIFont(name: "Menlo", size: 55)
//    titleLabel2.textColor = goldYellow
//
//        middleText.frame.size.width = 300
//        middleText.frame.size.height = 400
//        middleText.center.x = view.center.x
//        middleText.center.y = view.center.y - 50
//        middleText.text = "Do you want the good news or the good news first?"
//    middleText.numberOfLines = 0;
//        middleText.font = UIFont(name: "Hiragino Sans", size: 40)
//
//        registerView =  UIView(frame: CGRect(x: 100, y: 400, width: 350, height: 80))
//        registerView.applyDesign(color: bookmarkRed)
//    registerView.center.x = view.center.x
//    registerView.center.y = view.center.y + 250
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedRegister))
//    registerView.addGestureRecognizer(tap)
//
//        loginView =  UIView(frame: CGRect(x: 100, y: 400, width: 350, height: 80))
//        loginView.applyDesign(color: twitterBlue)
//        loginView.center.x = view.center.x
//        loginView.center.y = view.center.y + 140
////        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tappedLogin))
////        loginView.addGestureRecognizer(tap2)
//
//    registerLabel.applyDesign(text: "Register")
//        registerLabel.sizeToFit()
//    registerLabel.center.x = view.center.x
//        registerLabel.center.y = view.center.y + 250
//
//
//        loginLabel.applyDesign(text: "Login")
//        loginLabel.sizeToFit()
//        loginLabel.center.x = view.center.x
//    loginLabel.center.y = view.center.y + 140
//
//
//        view.addSubview(titleLabel1)
//    view.addSubview(titleLabel2)
//        view.addSubview(loginView)
//    view.addSubview(registerView)
//        view.addSubview(loginLabel)
//    view.addSubview(registerLabel)
//        view.addSubview(middleText)
//    }
//
//
//    //MARK: - Handlers
////    @objc func tappedLogin() {
////        let loginVC = LoginViewController()
////        self.navigationController?.pushViewController(loginVC, animated: false)
////    }
////
//    @objc func tappedRegister() {
//    print("tapped")
//    let registerVC = RegisterViewController()
//    self.navigationController?.pushViewController(registerVC, animated: false)
//    }
//}
>>>>>>> 49cb59c4c0edeeda307f43201cff65832e9e7e00
