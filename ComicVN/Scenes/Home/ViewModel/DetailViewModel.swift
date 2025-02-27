//
//  DetailViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    let itemsDetail = BehaviorRelay<[DetailModel]>(value: [])
    let itemsTrending = BehaviorRelay<[DetailModel]>(value: [])
    let itemsNewComic = BehaviorRelay<[DetailModel]>(value: [])
    

    
    init() {
        let exampleData = [
            DetailModel(image: UIImage(named: "test"), name: "Iron Man: Extremis ", rating: 5, author: "Warren Ellis", category: "Siêu Anh Hùng", views: "35.895.190"),
            DetailModel(image: UIImage(named: "test"), name: "Captain America", rating: 5, author: "Stan Lee", category: "Siêu Anh Hùng", views: "25.895.100"),
            DetailModel(image: UIImage(named: "test"), name: "Captain America", rating: 5, author: "Stan Lee", category: "Siêu Anh Hùng", views: "25.895.100"),
            DetailModel(image: UIImage(named: "test"), name: "Captain America", rating: 5, author: "Stan Lee", category: "Siêu Anh Hùng", views: "25.895.100"),
            DetailModel(image: UIImage(named: "test"), name: "Iron Man: Extremis ", rating: 5, author: "Warren Ellis", category: "Siêu Anh Hùng", views: "35.895.190"),
            DetailModel(image: UIImage(named: "test"), name: "Captain America", rating: 5, author: "Stan Lee", category: "Siêu Anh Hùng", views: "25.895.100"),
            DetailModel(image: UIImage(named: "test"), name: "Captain America", rating: 5, author: "Stan Lee", category: "Siêu Anh Hùng", views: "25.895.100"),
            DetailModel(image: UIImage(named: "test"), name: "Captain America", rating: 5, author: "Stan Lee", category: "Siêu Anh Hùng", views: "25.895.100")
        ]
        
        itemsDetail.accept(exampleData)
        itemsTrending.accept(exampleData)
        itemsNewComic.accept(exampleData)
    }
}
