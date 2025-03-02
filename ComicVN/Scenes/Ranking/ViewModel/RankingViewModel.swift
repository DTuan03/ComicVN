//
//  RankingViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//

import RxSwift
import RxCocoa

class RankingViewModel {
    var itemsRanking = BehaviorRelay<[InfoComicModel]>(value: [])
    
    init() {
        let exData = [
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
            InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        ]
        itemsRanking.accept(exData)
    }
}
