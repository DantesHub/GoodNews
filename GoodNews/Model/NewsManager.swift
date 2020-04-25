
import Foundation

var articleCount = 10

protocol NewsManagerDelegate {
    func didUpdateArticles()
}
var query: String? = "e"
   var count: String? = "10"
   var offset: String? = "0"
struct NewsManager {
    let newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9c92cd3bba5542e880b59aa89df77a2e"
    var delegate: NewsManagerDelegate?
    
    static var baseURL =  "https://newsapi.org"
    static let apiToken = "9c92cd3bba5542e880b59aa89df77a2e"

    let headers = [
        "x-rapidapi-host": "newslit-news-search.p.rapidapi.com",
        "x-rapidapi-key": "5c9c5e3954msh548fbb609a66f1cp1481cbjsna119d0a198e2"
    ]
   
    
    func fetchArticles(update: Bool = false) {
        let urlString = newsURL
//        performRequest(with: urlString)
        request(update: update)
    }
    
    func request(update: Bool = false) {
        let queryItems = [URLQueryItem(name: "q", value: query), URLQueryItem(name: "count", value: count), URLQueryItem(name: "offset", value: offset)]
            var urlComps = URLComponents(string: "https://newslit-news-search.p.rapidapi.com/news")!
            urlComps.queryItems = queryItems
            let result = urlComps.url!
        let request = NSMutableURLRequest(url: result,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
    
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) ->  Void in
            if (error != nil) {
                print("error")
            } else {
                let httpResponse = response as? HTTPURLResponse
            }
            if let safeData = data {
                    if self.parseJson(safeData, update: update) != nil {
                        self.delegate?.didUpdateArticles()
                    }
                }
        })

        dataTask.resume()
    }
    
    func parseJson(_ articleData: Data, update: Bool = false) -> Array<ArticleLitModel>? {
         let decoder = JSONDecoder()
        do {
            var articlesInside: [ArticleLitModel]
            print(update)
            if update == true || onHome == true {
                print("inside here")
                articlesInside = articles
            } else {
                print("over here")
                articlesInside =  [ArticleLitModel]()
            }
                if onHome {
                    for i in 0...Int(count!)! - 1{
                        let decodedData = try decoder.decode(ArticlesLitData.self, from: articleData).results
                        let urlImage = decodedData.stories[safe: i]?.image_url
                        let title = decodedData.stories[safe: i]?.title
                        let description = decodedData.stories[i].excerpt
                        let url = decodedData.stories[i].url
                        let source = decodedData.stories[i].source
                        let date = decodedData.stories[i].publication_date
                        let article = ArticleLitModel(title: title, description: description, urlImage: urlImage, url: url, publishedAt: date, source: source)
                        articlesInside.append(article)
                }
            }
            articles = articlesInside
            print(articles.count)
            return articlesInside
        } catch {
            print(error)
            return nil
        }
     }
//    func parseJSON(_ articleData: Data) -> Array<ArticleModel>? {
//        let decoder = JSONDecoder()
//               do {
//                var articlesInside = [ArticleModel]()
//                for i in 0...19 {
//
//
//                    let decodedData = try decoder.decode(ArticlesData.self, from: articleData)
//                    let urlImage = decodedData.articles[safe: i]?.urlToImage
//                    let title = decodedData.articles[safe: i]?.title
//                    let description = decodedData.articles[i].description
//                    let url = decodedData.articles[i].url
//                    let date = decodedData.articles[i].publishedAt
//                    let article = ArticleModel(title: title, description: description, urlImage: urlImage, url: url, publishedAt: date)
//                    articlesInside.append(article)
//
//                   }
////                   articles = articlesInside
//                   return articlesInside
//               } catch {
//                   print(error)
//                   return nil
//               }
//    }
//
//    func performRequest(with urlString: String, update: Bool = false) {
//        //create a URL
//            if let url = URL(string: urlString) {
//                //Create a URL session
//                let session = URLSession(configuration: .default)
//                //Give the session a taskd
//                let task = session.dataTask(with: url) { (data, response, error) in
//                    if error != nil {
//                        print(error!)
////                        self.delegate?.didFailWithError(error: error!)
//                        return
//                    }
//                    if let safeData = data {
//                        if update == false {
//                            if self.parseJSON(safeData) != nil {
//                                self.delegate?.didUpdateArticles()
//                            }
//                        }
//                    }
//                }
//                //Start the Task
//                task.resume()
//            }
//    }
    

    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension Array where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
