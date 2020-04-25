

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
