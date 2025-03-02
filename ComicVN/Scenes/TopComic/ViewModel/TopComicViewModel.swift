//
//  TopComicViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//

import UIKit
import RxSwift
import RxCocoa

class TopComicViewModel {
    var items = BehaviorRelay<(Int, [InfoComicModel])>(value: (10, []))
    var selectedSegment = BehaviorRelay<Int>(value: 0)
    let disposeBag = DisposeBag()
    
    
    let exDataWeak = [
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
    ]
    let exDataMonth = [
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444")
    ]
    let exDataReviews = [
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444"),
        InfoComicModel(avatar: UIImage.test, name: "Iron Man: Extremis", rating: 4, author: "Warren Ellis", category: "Siêu anh hùng", views: "34.344.444")
    ]
    
    init() {
        setupBinding()
    }
    
    private func setupBinding() {
        selectedSegment
            .map { index -> (Int, [InfoComicModel]) in
                switch index {
                case 0: return (0, self.exDataWeak)
                case 1: return (1, self.exDataMonth)
                case 2: return (2, self.exDataReviews)
                default: return (10, [])
                }
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
}
