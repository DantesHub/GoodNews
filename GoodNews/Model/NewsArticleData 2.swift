//
//  NewsArticleData.swift
//  GoodNews
//
//  Created by Dante Kim on 4/17/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import Foundation

struct ArticlesData: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    let publishedAt: String?
}

