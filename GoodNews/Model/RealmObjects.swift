

import Foundation
import RealmSwift

class SavedArticle: Object {
    //MARK: - Properties
    @objc var title: String? = nil
    @objc  var desc: String? = nil
    @objc  var urlImage: String? = nil
    @objc  var url: String? = nil
    @objc  var publishedAt: String? = nil
    @objc var isBookmarked = false
    
    //MARK: - init
    override static func primaryKey() -> String? {
        return "url"
    }
}

class User: Object {
    @objc var isLoggedIn: Bool = false
    @objc var email: String? = nil
    
    //MARK: - init
    override static func primaryKey() -> String? {
        return "email"
    }
}


//MARK: -extensions
extension SavedArticle {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self, update: .modified)
        }
    }
}
