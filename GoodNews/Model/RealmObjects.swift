

import Foundation
import RealmSwift

class SavedArticle: Object {
    //MARK: - Properties
    @objc dynamic var title: String? = nil
    @objc dynamic var desc: String? = nil
    @objc  dynamic var urlImage: String? = nil
    @objc  dynamic var url: String? = nil
    @objc dynamic var publishedAt: String? = nil
    @objc dynamic var isBookmarked = false
    
    //MARK: - init
    override static func primaryKey() -> String? {
        return "url"
    }
}

class User: Object {
    @objc dynamic var isLoggedIn = false
    @objc dynamic var email: String? = nil
    
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
extension User {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self, update: .modified)
        }
    }
}
