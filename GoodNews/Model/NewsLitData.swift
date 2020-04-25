
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
