import UIKit
import Firebase
import RealmSwift
var loggedOut = false
var isLoggedIn = false
class LoginViewController: UIViewController {
    var goToTimerView = UIView()
    var goToTimerLabel = UILabel()
    var email = UITextField()
    var password = UITextField()
    var loginTitle = UILabel()
    var loginButtonView = UIView()
    var loginButtonLabel = UILabel()
    var errorLabel: UILabel!
    var emailIsValid = false
    let db = Firestore.firestore()
    var results: Results<User>!
    var passwordIsValid = false
    var forgotEmailField = UITextField()
    let container: UIView = UIView()
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var forgotPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loginTitle.frame.size.width = 300
        loginTitle.frame.size.height = 100
        loginTitle.center.x = view.center.x + 70
        loginTitle.center.y = view.center.y - 180
        loginTitle.text = "Login"
        loginTitle.font = UIFont(name: "Menlo-Bold", size: 55)
        loginTitle.textColor = twitterBlue
        view.addSubview(loginTitle)
        
        loginButtonView =  UIView(frame: CGRect(x: 100, y: 400, width: 350, height: 60))
        loginButtonView.applyDesign(color: twitterBlue)
        loginButtonView.center.x = view.center.x
        loginButtonView.center.y = view.center.y + 200
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedLogin))
        loginButtonView.addGestureRecognizer(tap)
        view.addSubview(loginButtonView)
        
        loginButtonLabel.applyDesign(text: "Sign in")
        loginButtonLabel.sizeToFit()
        loginButtonLabel.center.x = view.center.x
        loginButtonLabel.center.y = view.center.y + 200
        view.addSubview(loginButtonLabel)
        // Do any additional setup after loading the view.
        loadTextViews()
        loadForgotPassword()
        
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
        let backButton = UIBarButtonItem.init(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func forgotPasswordTapped() {
        let alert = UIAlertController(title: "Enter email you used to sign up with", message:nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "example@email.com"
        }
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            if let emailString = alert.textFields?.first?.text {
                Auth.auth().sendPasswordReset(withEmail: emailString) { error in
                    if error != nil {
                        self.errorLabel =  UILabel(frame: CGRect(x: self.view.center.x - 100, y: self.password.center.y + 50 , width: 350, height: 50))
                        self.errorLabel.text =  "Email does not exist"
                        self.errorLabel.textColor = .red
                        self.view.addSubview(self.errorLabel)
                    } else {
                        self.errorLabel.removeFromSuperview()
                    }
                }
            }
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func showSpinner() {
        spinner.hidesWhenStopped = true
        container.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000) // Set X and Y whatever you want
        container.backgroundColor = .clear
        spinner.center = self.view.center
        view.addSubview(container)
        container.addSubview(spinner)
        spinner.startAnimating()
    }
    
    
    
    @objc func tappedLogin() {
        // do something here
        showSpinner()
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { result, error in
            if error != nil {
                self.errorLabel =  UILabel(frame: CGRect(x: self.view.center.x - 130, y: self.password.center.y + 50 , width: 350, height: 50))
                self.errorLabel.text = "username or password is incorrect"
                self.errorLabel.textColor = .red
                self.view.addSubview(self.errorLabel)
                //                self.errorLabel.topAnchor.constraint(equalTo: self.password.bottomAnchor, constant: 30).isActive = true
                self.spinner.stopAnimating()
                self.container.removeFromSuperview()
            } else {
                let settingsVC = SettingsController()
                settingsVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(settingsVC, animated: true)
                                self.saveToRealm()
            }
        }
    }
    
    
    func loadTextViews() {
        email.placeholder = "Email"
        view.addSubview(email)
        email.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 25).isActive = true
        email.applyDesign(view, x: -165, y: -110)
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        view.addSubview(password)
        password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 30).isActive = true
        password.applyDesign(view, x: -165, y: -5)
        
        
    }
    
    
    func loadForgotPassword() {
        forgotPassword = UILabel(frame: CGRect(x: view.center.x - 100, y: loginButtonView.center.y + 30 , width: 350, height: 50))
        forgotPassword.attributedText = NSAttributedString(string: "Forgot my password", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        forgotPassword.textColor = .blue
        forgotPassword.font = UIFont(name: "Menlo", size: 18)
        view.addSubview(forgotPassword)
        
        let tapForgot = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPassword.isUserInteractionEnabled = true
        forgotPassword.addGestureRecognizer(tapForgot)
    }
    //
        func saveToRealm() {
            results = uiRealm.objects(User.self)
            for result  in results {
                if result.email == Auth.auth().currentUser?.email {
                    do {
                        try uiRealm.write {
                            print("saved")
                            loggedOut = false
                            result.setValue(true, forKey: "isLoggedIn")
                        }
    
                    } catch {
                        print(error)
                    }
                  return
                }
            }
            createRealmData()
        }
    
 func createRealmData() {
      let realmUser = User()
      realmUser.email = Auth.auth().currentUser?.email
      realmUser.isLoggedIn = true
      realmUser.writeToRealm()
  }
    
}
