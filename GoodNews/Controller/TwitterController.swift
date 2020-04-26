//
//  TwitterController.swift
//  GoodNews
//
//  Created by Dante Kim on 4/25/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private var tweets = [Tweet]()

func populateTweets() {
    tweets.append(Tweet(tweetID: "johnkrasinski", dictionary:[
        "caption": "Ok, this week on @somegoodnews...Is the #SGNCookOff!!! Send us your favorite family recipe and why it's so special to you?... and my friends and I just might have to cook it!!",
        "likes": 8200,
        "retweet": 334,
        "uid": "John Krasinski @johnkrasinski",
        "timestamp": "Apr 21"]))
    tweets.append(Tweet(tweetID: "johnkrasinski", dictionary:[
    "caption": "Episode 4 of @somegoodnews ! I know I shouldn't play favorites but... Sorry this is some of the most fun I've ever had! #Classof2020 #SGNprom !!!",
    "likes": 12100,
    "retweet": 1400,
    "uid": "John Krasinski @johnkrasinski",
    "timestamp": "Apr 19"]))
    tweets.append(Tweet(tweetID: "johnkrasinski", dictionary:[
    "caption": "Goodnight class of 2020!!! Happy prom!!! #SGNProm",
    "likes": 21400,
    "retweet": 662,
    "uid": "John Krasinski @johnkrasinski",
    "timestamp": "Apr 17"]))
    tweets.append(Tweet(tweetID: "johnkrasinski", dictionary:[
    "caption": "Thank you ALL for being a part of the most DIY prim in history!!! #SGNProm !!! And if you wanna see how life is really done head over to the after party with my hero @dnice on Instagram live!!!",
    "likes": 21700,
    "retweet": 651,
    "uid": "John Krasinski @johnkrasinski",
    "timestamp": "Apr 17"]))
    tweets.append(Tweet(tweetID: "somegoodnews", dictionary:[
    "caption": "Run, Bill, Run!",
    "likes": 1000,
    "retweet": 24,
    "uid": "Some Good News @somegoodnews",
    "timestamp": "Apr 25"]))
    tweets.append(Tweet(tweetID: "johnkrasinski", dictionary:[
    "caption": "Thank each and every one of your extraordinary team for helping us make magic! An incredibly special moment! Thankyou!",
    "likes": 1000,
    "retweet": 24,
    "uid": "John Krasinski @johnkrasinski",
    "timestamp": "Apr 12"]))
    tweets.append(Tweet(tweetID: "somegoodnews", dictionary:[
    "caption": "Very cool to be included in this. Thank you @Apple",
    "likes": 1000,
    "retweet": 24,
    "uid": "John Krasinski @johnkrasinski",
    "timestamp": "Apr 11"]))
    tweets.append(Tweet(tweetID: "somegoodnews", dictionary:[
    "caption": "Episode 3 of @somegoodnews ! Play ball!",
    "likes": 1000,
    "retweet": 24,
    "uid": "John Krasinski @johnkrasinski",
    "timestamp": "Apr 12"]))
}

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
        
        populateTweets()
    }
}

extension TwitterController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}

extension TwitterController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
