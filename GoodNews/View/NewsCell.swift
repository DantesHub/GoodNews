//
//  NewsCell.swift
//  GoodNews
//
//  Created by Dante Kim on 4/16/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit
import RealmSwift
import Lottie

class NewsCell: UITableViewCell {
    //MARK: - properties
    var results: Results<SavedArticle>!
    var articleData: ArticleLitModel?
    var articleImageView = UIImageView()
    var articleTitleLabel = UILabel()
    var containerView = UIView()
    var saveButton = UIButton()
    var shareButton = UIButton()
    var bookmark: UIImageView = {
        let image = UIImage(named: "bookmark")
        let iv = UIImageView()
        iv.image = image
        return iv
    }()
    var dateLabel = UILabel()
    
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(containerView)
        configureContainerView()
        containerView.addSubview(articleImageView)
        configureImageView()
        containerView.addSubview(articleTitleLabel)
        configureTitleLabel()
        containerView.addSubview(bookmark)
        containerView.addSubview(dateLabel)
        configureDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configureContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = false
        containerView.backgroundColor = neoWhite
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 10, height: 10)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = false
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 450).isActive                   = true
    }
    
    
    func configureImageView() {
        articleImageView.layer.cornerRadius = 20
        articleImageView.clipsToBounds      = true
        articleImageView.translatesAutoresizingMaskIntoConstraints                                             = false
        articleImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30).isActive         = true
        articleImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                             = true
        articleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 230).isActive                                = true
    }
    
    func configureTitleLabel() {
        articleTitleLabel.numberOfLines             = 5
        articleTitleLabel.adjustsFontSizeToFitWidth = false
        articleTitleLabel.lineBreakMode = .byTruncatingTail
        articleTitleLabel.font = UIFont(name:
            "Georgia-Bold", size: 20)
        articleTitleLabel.translatesAutoresizingMaskIntoConstraints                                                 = false
        articleTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 10).isActive                   = true
        articleTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive  = true
        articleTitleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: -10).isActive      = true
        articleTitleLabel.heightAnchor.constraint(equalToConstant: 150).isActive                                    = true
    }
    func configureBookmark() {
        results = uiRealm.objects(SavedArticle.self)
        for result  in results {
            let url = result.value(forKey: "url") as! String?
            let bookmarked = result.value(forKey: "isBookmarked") as! Bool
            if url == articleData?.url && bookmarked == true {
                print("past second defense")
                bookmark.image = UIImage(named: "bookmarked")
            } 
        }
        bookmark.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedBookmark))
        bookmark.addGestureRecognizer(tap)
        bookmark.translatesAutoresizingMaskIntoConstraints = false
        bookmark.clipsToBounds = true
        bookmark.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        bookmark.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive     = true
    }
    
    func configureDate() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        dateLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 15).isActive = false
        dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15).isActive = true
    }
    
    func set(article: ArticleLitModel) {
        articleData = article
        do {
            let data = try Data(contentsOf: URL(string: article.urlImage ?? "https://images.squarespace-cdn.com/content/54f74f23e4b0952b4e0011c0/1586266817391-01RX6GM2TOXCXB5BQ0F2/yDAoxcnp_400x400.jpg?content-type=image%2Fjpeg")!)
            articleImageView.image =  UIImage(data: data)
        } catch {
            print("There is no picture for this article")
        }
        let dateFormatter = DateFormatter()
        let string = article.publishedAt!
        let newString = string.prefix(10)
        let array = newString.components(separatedBy: "-")
        var month : String {
            get {
                switch array[1] {
                case "01":
                    return "January"
                case "02":
                    return "February"
                case "03":
                    return "March"
                case "04":
                    return "April"
                case "05":
                    return "May"
                case "06":
                    return "June"
                case "07":
                    return "July"
                case "08":
                    return "August"
                case "09":
                    return "September"
                case "10":
                    return "October"
                case "11":
                    return "November"
                case "12":
                    return "December"
                default:
                    return "May"
                }
            }
        }
        let finalString = "\(month) \(array[2]) \(array[0])"
        dateLabel.text = finalString
        
        articleTitleLabel.text = "\(article.title ?? "") \n-\(article.source ?? "")"
    }
    //MARK: - handlers
    @objc func tappedBookmark() {
        print("i pull up")
        if bookmark.image == UIImage(named: "bookmark") {
            bookmark.image = UIImage(named: "bookmarked")
            bookmark.startAnimating()
            saveToRealm()
        } else {
            bookmark.image = UIImage(named: "bookmark")
            deleteFromRealm()
        }
    }
    
    func saveToRealm() {
        let savedArticle = SavedArticle()
        savedArticle.title = articleData?.title
        savedArticle.desc = articleData?.description
        savedArticle.publishedAt = articleData?.publishedAt
        savedArticle.url = articleData?.url
        savedArticle.isBookmarked = true
        savedArticle.urlImage = articleData?.urlImage
        savedArticle.writeToRealm()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func deleteFromRealm() {
        results = uiRealm.objects(SavedArticle.self)
        for result in results {
            let url = result.value(forKey: "url") as! String?
            if url == articleData!.url {
              
                do {
                    try uiRealm.write {
                        uiRealm.delete(result)
                    }
                } catch {
                    print(error)
                }

            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        }
    }
}
