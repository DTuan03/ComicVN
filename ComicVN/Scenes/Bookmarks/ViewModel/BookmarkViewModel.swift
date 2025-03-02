//
//  BookmarksViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 2/3/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewModel {
    var itemsBookmark = BehaviorRelay<[BookmarkModel]>(value: [])
    
    init() {
        let exData = [
            BookmarkModel(avatar: UIImage.test, name: "Iron Man: Extremis", author: "Warren Ellis", category: "Siêu anh hùng", totalChapter: "24"),
            BookmarkModel(avatar: UIImage.test, name: "Iron Man: Extremis", author: "Warren Ellis", category: "Siêu anh hùng", totalChapter: "24"),
            BookmarkModel(avatar: UIImage.test, name: "Iron Man: Extremis", author: "Warren Ellis", category: "Siêu anh hùng", totalChapter: "24"),
            BookmarkModel(avatar: UIImage.test, name: "Iron Man: Extremis", author: "Warren Ellis", category: "Siêu anh hùng", totalChapter: "24"),
            BookmarkModel(avatar: UIImage.test, name: "Iron Man: Extremis", author: "Warren Ellis", category: "Siêu anh hùng", totalChapter: "24")
        ]
        itemsBookmark.accept(exData)
    }
}
