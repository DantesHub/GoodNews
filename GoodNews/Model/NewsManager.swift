
import Foundation

var articleCount = 10

protocol NewsManagerDelegate {
    func didUpdateArticles()
}
 var query: String? = "e"
   var count: String? = "100"
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
    
    func checkIfPositive(title: String, index: Int) -> Bool {
        var pos = false
        let sentimentAnalyzer = SentimentAnalyzer()
        let prediction = try! sentimentAnalyzer.prediction(text: title)
        if prediction.label == "Pos" {
            pos = true
        } else {
            pos = false
        }
        return pos
    }
    
    func parseJson(_ articleData: Data, update: Bool = false) -> Array<ArticleLitModel>? {
         let decoder = JSONDecoder()
        do {
            var articlesInside: [ArticleLitModel]
            if update == true || (onHome == true && clicked == false) {
                articlesInside = articles
            } else {
                clicked = false
                articlesInside =  [ArticleLitModel]()
            }
                if onHome {
                    for i in 0...Int(count!)! - 1{
                        let decodedData = try decoder.decode(ArticlesLitData.self, from: articleData).results
                        let urlImage = decodedData.stories[safe: i]?.image_url
                        let title = decodedData.stories[safe: i]?.title
                        // add helper function, continue if not positive title
                        if !checkIfPositive(title: title!, index: i) {
                            continue
                        }
                        
                        let description = decodedData.stories[i].excerpt
                        let url = decodedData.stories[i].url
                        let source = decodedData.stories[i].source
                        let date = decodedData.stories[i].publication_date
                        let article = ArticleLitModel(title: title, description: description, urlImage: urlImage, url: url, publishedAt: date, source: source)
                        articlesInside.append(article)
                }
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
