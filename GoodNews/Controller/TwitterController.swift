//
//  TwitterController.swift
//  GoodNews
//
//  Created by Dante Kim on 4/25/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TweetCell"

class TwitterController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // configureNavBar()
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Menlo-Bold", size: 30)!]
        //        UINavigationBar.appearance().shadowImage = UIImage()
        //        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = false;
        navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Twitter"
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitterIcon"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        
        
    }
}

extension TwitterController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        return cell
    }
}

extension TwitterController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
