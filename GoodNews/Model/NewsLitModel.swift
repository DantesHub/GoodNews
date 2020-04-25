//
//  NewsLitModel.swift
//  GoodNews
//
//  Created by Dante Kim on 4/25/20.
//  Copyright © 2020 Dante Kim. All rights reserved.
//

import Foundation

struct ArticleLitModel: Equatable {
    var title: String?
    var description: String?
    var urlImage: String?
    var url: String?
    var publishedAt: String?
    var source: String? 
    
    static func ==(lhs: ArticleLitModel, rhs: ArticleLitModel) -> Bool {
           return lhs.url == rhs.url
       }
}
