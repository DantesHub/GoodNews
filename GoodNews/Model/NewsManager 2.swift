//
//  NewsManager.swift
//  GoodNews
//
//  Created by Dante Kim on 4/17/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import Foundation

var articleCount = 10

protocol NewsManagerDelegate {
    func didUpdateArticles()
}

struct NewsManager {
    let newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9c92cd3bba5542e880b59aa89df77a2e"
    var delegate: NewsManagerDelegate?
    
    static var baseURL =  "https://newsapi.org"
    static let apiToken = "9c92cd3bba5542e880b59aa89df77a2e"

    
    
    func fetchArticles() {
        let urlString = newsURL
        performRequest(with: urlString)
    }
    func fetchSportsArticles() {
        
    }
    func fetchMoreArticles() {
        let urlString = newsURL
        performRequest(with: urlString, update: true)
    }
    
    func performRequest(with urlString: String, update: Bool = false) {
        //create a URL
            if let url = URL(string: urlString) {
                //Create a URL session
                let session = URLSession(configuration: .default)
                //Give the session a taskd
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil {
                        print(error!)
//                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        if update == false {
                            if self.parseJSON(safeData) != nil {
                                self.delegate?.didUpdateArticles()
                            }
                        } 
                    }
                }
                //Start the Task
                task.resume()
            }
    }
    
    func parseJSON(_ articleData: Data) -> Array<ArticleModel>? {
         let decoder = JSONDecoder()
        do {
            var articlesInside = [ArticleModel]()
            for i in 0...19 {
                let decodedData = try decoder.decode(ArticlesData.self, from: articleData)
                let urlImage = decodedData.articles[safe: i]?.urlToImage
                let title = decodedData.articles[safe: i]?.title
                let description = decodedData.articles[i].description
                let url = decodedData.articles[i].url
                let date = decodedData.articles[i].publishedAt
                let article = ArticleModel(title: title, description: description, urlImage: urlImage, url: url, publishedAt: date)
                articlesInside.append(article)
                
            }
            articles = articlesInside
            return articlesInside
        } catch {
            print(error)
            return nil
        }
     }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension Array where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
