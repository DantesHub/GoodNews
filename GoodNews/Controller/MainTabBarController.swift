

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = .white
        self.tabBarController?.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.tabBarController?.tabBar.layer.shadowRadius = 5
        self.tabBarController?.tabBar.layer.shadowOpacity = 1
        setUpTabBar()
    }
    
    //MARK: - helper functions
    func setUpTabBar() {
        let homeController = UINavigationController(rootViewController: HomeController())
        homeController.tabBarItem.image =  UIImage(named: "newsIcon")
        homeController.tabBarItem.selectedImage = UIImage(named: "newsIconSelected")
        
        let savedController = UINavigationController(rootViewController: BookmarkController())
        
        savedController.tabBarItem.image = UIImage(named: "bookmarkIcon")
        savedController.tabBarItem.selectedImage = UIImage(named: "bookmarkIconSelected")
        
        let userController = UINavigationController(rootViewController: UserProfileController())
        userController.tabBarItem.image = UIImage(named: "accountIcon")
        userController.tabBarItem.selectedImage = UIImage(named: "accountIconSelected")
        
        let twitterController = UINavigationController(rootViewController: TwitterController())
        twitterController.tabBarItem.image = UIImage(named: "twitterIcon")
        twitterController.tabBarItem.selectedImage = UIImage(named: "twitterIconSelected")

        viewControllers = [savedController, homeController , twitterController, userController]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
        }
    }
    
}
