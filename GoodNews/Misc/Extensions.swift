

import Foundation
import UIKit

extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension UILabel {
    func applyDesign() {
        self.setLineSpacing(lineSpacing: 4, lineHeightMultiple: 1)
        self.numberOfLines = 2
        self.font = UIFont(name: "Menlo-Bold", size: 40)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func applyDesign(text: String) {
        self.font = UIFont(name: "Menlo", size: 25)
        self.text = text
        self.textAlignment = .center
        self.textColor = .white
    }
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

extension UIViewController {
    func configureTableView(tableView: UITableView) {
         //set row height
         tableView.rowHeight = 400
         //register cells
         tableView.register(NewsCell.self, forCellReuseIdentifier: K.newsCell)
         //set constraints
         tableView.pin(to:view)
         tableView.separatorStyle = .none
     }
}

extension UIViewController {
    func configureNavBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 30)!]
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = false;
    }
}

extension UIView {
    func pin(to view: UIView) {
           translatesAutoresizingMaskIntoConstraints = false
           topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
           bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func applyDesign(color: UIColor) {
          self.backgroundColor = color
          self.layer.cornerRadius = 25
          self.layer.shadowColor = UIColor.black.cgColor
          self.layer.shadowOpacity = 0.5;
          self.layer.shadowRadius = 12
          self.layer.shadowOffset = CGSize(width: 10, height: 10)
      }
}

