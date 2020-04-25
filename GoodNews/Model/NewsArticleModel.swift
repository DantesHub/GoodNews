
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


