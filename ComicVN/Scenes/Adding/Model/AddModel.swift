//
//  AddModel.swift
//  ComicVN
//
//  Created by Tuấn on 4/3/25.
//
import RealmSwift

class AddModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var image: Data? = nil
    @objc dynamic var name: String = ""
    @objc dynamic var avgRating: Int = 0
    @objc dynamic var category: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var views: String = "0"
    @objc dynamic var totalChapter: Int = 0
    @objc dynamic var status: Bool = false
    @objc dynamic var summary: String = ""
    @objc dynamic var isTrending: Bool = false
    @objc dynamic var isNewComic: Bool = false
    @objc dynamic var topWeak: Bool = false
    @objc dynamic var topMonth: Bool = false
    @objc dynamic var topReviews: Bool = false

    
    override static func primaryKey() -> String? {
            return "id"
        }
}
