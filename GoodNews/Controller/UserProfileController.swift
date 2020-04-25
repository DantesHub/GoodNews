
import UIKit

class UserProfileController: UIViewController {
    //MARK: - Properties
    
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
    }
    
    //MARK: - Handlers
}
