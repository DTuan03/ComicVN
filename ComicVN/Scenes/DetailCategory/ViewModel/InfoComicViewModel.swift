//
//  InfoComicViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import RxSwift
import RxCocoa

class InfoComicViewModel {
    var itemsInfoComic = BehaviorRelay<[InfoComicModel]>(value: [])
    
    init() {
        let exData = [
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        ]
        itemsInfoComic.accept(exData)
    }
}
