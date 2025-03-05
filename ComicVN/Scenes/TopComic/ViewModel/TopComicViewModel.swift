//
//  TopComicViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class TopComicViewModel {
    var items = BehaviorRelay<(Int, [InfoComicModel])>(value: (10, []))
    var selectedSegment = BehaviorRelay<Int>(value: 0)
    let disposeBag = DisposeBag()
    
    init() {
        setupBinding()
    }
    
    func getWeak() -> [AddModel] {
        let predicate = NSPredicate(format: "topWeak == %@", NSNumber(value: true))
        return RealmHelper.get(AddModel.self, filter: predicate)
    }
    
    func getMonths() -> [AddModel] {
        let predicate = NSPredicate(format: "topMonth == %@", NSNumber(value: true))
        return RealmHelper.get(AddModel.self, filter: predicate)
    }
    
    func getReview() -> [AddModel] {
        let predicate = NSPredicate(format: "topReviews == %@", NSNumber(value: true))
        return RealmHelper.get(AddModel.self, filter: predicate)
    }
    
    func mapAddModelsToInfoComicModels(addModels: [AddModel]) -> [InfoComicModel] {
        return addModels.map { mapAddModelToInfoComicModel(addModel: $0) }
    }

    func mapAddModelToInfoComicModel(addModel: AddModel) -> InfoComicModel {
        return InfoComicModel(
            avatar: UIImage(data: addModel.image ?? Data()),
            name: addModel.name,
            rating: Double(addModel.avgRating),
            author: addModel.author,
            category: addModel.category,
            views: addModel.views
        )
    }
    
    func setupBinding() {
        selectedSegment
            .map { index -> (Int, [InfoComicModel]) in
                switch index {
                case 0:
                    return (0, self.mapAddModelsToInfoComicModels(addModels: self.getWeak()))
                case 1:
                    return (1, self.mapAddModelsToInfoComicModels(addModels: self.getMonths()))
                case 2:
                    return (2, self.mapAddModelsToInfoComicModels(addModels: self.getReview()))
                default: return (10, [])
                }
            }
            .bind(to: items)
            .disposed(by: disposeBag)
    }
}
