
import UIKit

class UserProfileController: UIViewController {
    //MARK: - Properties
    var loginView = UIView()
    var registerView = UIView()
    var loginLabel = UILabel()
    var registerLabel = UILabel()
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let middleText = UILabel()
    
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        onHome = false
        configureNavBar()
        configureUI()
        
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
        titleLabel1.text = "TIMER"
        titleLabel1.font = UIFont(name: "Menlo", size: 55)
        titleLabel1.textColor = brightPurple
        
        titleLabel2.frame.size.width = 300
        titleLabel2.frame.size.height = 100
        titleLabel2.center.x = view.center.x + 185
        titleLabel2.center.y = view.center.y - 200
        titleLabel2.text = "APP"
        titleLabel2.font = UIFont(name: "Menlo", size: 55)
        titleLabel2.textColor = .black
        
        
        middleText.frame.size.width = 300
        middleText.frame.size.height = 400
        middleText.center.x = view.center.x
        middleText.center.y = view.center.y - 50
        middleText.text = "Level up and have fun while you study and do work. "
        middleText.numberOfLines = 0;
        middleText.font = UIFont(name: "Hiragino Sans", size: 40)
        
        registerView =  UIView(frame: CGRect(x: 100, y: 400, width: 350, height: 80))
        registerView.applyDesign(color: lightLavender)
        registerView.center.x = view.center.x
        registerView.center.y = view.center.y + 250
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedRegister))
        registerView.addGestureRecognizer(tap)
        
        loginView =  UIView(frame: CGRect(x: 100, y: 400, width: 350, height: 80))
        loginView.applyDesign(color: brightPurple)
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
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc func tappedRegister() {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

}
