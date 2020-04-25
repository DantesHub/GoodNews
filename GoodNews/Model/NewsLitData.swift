//
//  NewsLitData.swift
//  GoodNews
//
//  Created by Dante Kim on 4/25/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import Foundation

struct ArticlesLitData: Codable {
    let results: Resultz
}

struct ArticleLit: Codable {
    let title: String?
    let excerpt: String?
    let image_url: String?
    let url: String?
    let publication_date: String?
    let source: String?
}

struct Resultz: Codable {
    let stories: [ArticleLit]
}
