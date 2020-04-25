//
//  NewsArticleModel.swift
//  GoodNews
//
//  Created by Dante Kim on 4/17/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import Foundation

struct ArticleModel: Equatable {
    var title: String?
    var description: String?
    var urlImage: String?
    var url: String?
    var publishedAt: String?
    
    static func ==(lhs: ArticleModel, rhs: ArticleModel) -> Bool {
           return lhs.url == rhs.url
       }
}


