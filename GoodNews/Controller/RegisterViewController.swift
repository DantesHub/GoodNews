
import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuth
import Validator
import RealmSwift

var userEmail = ""
class RegisterViewController: UIViewController {
    
    //MARK: - properties
    var results: Results<User>!
    var registerTitle = UILabel()
    var password = UITextField()
    var email = UITextField()
    var passwordConfirmation = UITextField()
    var signUpView = UIView()
    var signUpLabel = UILabel()
    var registerErrorLabel = UILabel(frame: CGRect(x: 100, y: 620, width: 350, height: 45))
    var emailIsValid = false
    var passwordIsValid = false
    var passwordConfirmationIsValid = false
    var ValInput = ValidateInputs()
    let container: UIView = UIView()
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let backButton = UIBarButtonItem.init(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(goBack))
             self.navigationItem.leftBarButtonItem = backButton
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Handlers
    
    @objc func tappedRegister() {
        showSpinner()
        if let constant = email.text {
            ValInput.email = constant
            emailIsValid = ValInput.isEmailValid()
            if emailIsValid {
                let color = UIColor.lightGray
                let placeholder = "Email" //There should be a placeholder set in storyboard or elsewhere string or pass empty
                email.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
            } else {
                let color = UIColor.red
                let placeholder = "Invalid Email" //There should be a placeholder set in storyboard or elsewhere string or pass empty
                email.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
                self.spinner.stopAnimating()
                container.removeFromSuperview()
            }
        }
        if let constant = password.text {
            ValInput.password = constant
            passwordIsValid = ValInput.isPasswordLengthValid()
            let passwordIsNumeric = ValInput.doesPasswordHaveDigits()
            if passwordIsValid && passwordIsNumeric{
                let color = UIColor.lightGray
                let placeholder = "Password" //There should be a placeholder set in storyboard or elsewhere string or pass empty
                password.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
            } else if !passwordIsValid {
                password.text = ""
                let color = UIColor.red
                let placeholder = "At least 5 characters" //There should be a placeholder set in storyboard or elsewhere string or pass empty
                password.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
                self.spinner.stopAnimating()
                container.removeFromSuperview()
            } else if !passwordIsNumeric {
                password.text = ""
                let color = UIColor.red
                let placeholder = "Must contain numbers"
                password.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
                self.spinner.stopAnimating()
                container.removeFromSuperview()
            }
            
        }
        
        if let constant = passwordConfirmation.text {
            ValInput.passwordConfirmation = constant
            passwordConfirmationIsValid = ValInput.isPasswordConfirmationValid()
            if passwordConfirmationIsValid {
                let color = UIColor.lightGray
                let placeholder = "Password Confirmation" //There should be a placeholder set in storyboard or elsewhere string or pass empty
                passwordConfirmation.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
            } else {
                passwordConfirmation.text = ""
                let color = UIColor.red
                let placeholder = "Passwords do not match"
                passwordConfirmation.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
                self.spinner.stopAnimating()
                container.removeFromSuperview()
            }
        }
        if emailIsValid && passwordIsValid && passwordConfirmationIsValid {
            Auth.auth().createUser(withEmail: ValInput.email, password: ValInput.password) { result, error in
                // [START_EXCLUDE]
                if error != nil {
                    self.registerErrorLabel.text = "Something went wrong"
                    self.registerErrorLabel.textColor = .red
                    self.registerErrorLabel.center.y = self.view.center.y + 220
                    self.view.addSubview(self.registerErrorLabel)
                    self.container.removeFromSuperview()
                    self.spinner.stopAnimating()
                    return
                }
                userEmail = self.ValInput.email
                print(userEmail)
                self.spinner.stopAnimating()
                let settingsVC = SettingsController()
                self.saveToRealm()
                settingsVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(settingsVC, animated: false)
            }
        }
    }

    //MARK: - Helper functions
    func configureUI() {
        registerTitle.text = "Sign up"
        registerTitle.textAlignment = .center
        registerTitle.font = UIFont(name:"Menlo-Bold", size: 55)
        registerTitle.textColor = bookmarkRed
        registerTitle.frame.size.width = 300
        registerTitle.frame.size.height = 100
        registerTitle.center.x = view.center.x
        registerTitle.center.y = view.center.y - 230
        view.addSubview(registerTitle)
        
        signUpView =  UIView(frame: CGRect(x: 100, y: view.center.y + 270, width: 350, height: 60))
        signUpView.applyDesign(color: bookmarkRed)
        signUpView.center.x = view.center.x
        signUpView.center.y = view.center.y + 270
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedRegister))
        signUpView.addGestureRecognizer(tap)
        view.addSubview(signUpView)
        
        signUpLabel.applyDesign(text: "Register")
        signUpLabel.sizeToFit()
        signUpLabel.center.x = view.center.x
        signUpLabel.center.y = view.center.y + 270
        view.addSubview(signUpLabel)
        loadTextFields()
    }
    
    func loadTextFields() {
        email.placeholder = "Email"
        view.addSubview(email)
        email.topAnchor.constraint(equalTo: self.registerTitle.bottomAnchor, constant: 15).isActive = true
        email.applyDesign(view, x: -165, y: -170)
        
        password.isSecureTextEntry = true
        password.placeholder = "Password"
        view.addSubview(password)
        password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 28).isActive = true
        password.applyDesign(view, x: -165, y: -70)
        
        passwordConfirmation.isSecureTextEntry = true
        passwordConfirmation.placeholder = "Password Confirmation"
        view.addSubview(passwordConfirmation)
        passwordConfirmation.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 32).isActive = true
        passwordConfirmation.applyDesign(view, x: -165, y: 40)
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
    
     func saveToRealm() {
            let realmUser = User()
            realmUser.email = Auth.auth().currentUser?.email
            realmUser.isLoggedIn = true
            realmUser.writeToRealm()
    }
}

