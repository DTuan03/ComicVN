//
//  BookmarksViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 2/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class BookmarkViewModel {
    var itemsBookmark = BehaviorRelay<[BookmarkModel]>(value: [])
    
    init() {}
    
    func getBookmark(userId: String) -> [BookmarkRealmModel] {
        let predicate = NSPredicate(format: "userId == %@", userId)
        return RealmHelper.get(BookmarkRealmModel.self, filter: predicate)
    }
    
    func mapAddModelsToBookmarkModels(bookmarkModel: [BookmarkRealmModel]) -> [BookmarkModel] {
        return bookmarkModel.map { mapAddModelToBookmarkModel(bookmarkModel: $0) }
    }

    func mapAddModelToBookmarkModel(bookmarkModel: BookmarkRealmModel) -> BookmarkModel {
        return BookmarkModel(
            avatar: UIImage(data: bookmarkModel.image ?? Data()) ?? UIImage(),
            name: bookmarkModel.name ?? "",
            author: bookmarkModel.author ?? "",
            category: bookmarkModel.category ?? "",
            totalChapter: String(bookmarkModel.totalChapter)
        )
    }
}
