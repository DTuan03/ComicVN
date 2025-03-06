//
//  RankingViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//

import RxSwift
import RxCocoa
import RealmSwift

class RankingViewModel {
    var itemsRanking = BehaviorRelay<[InfoComicModel]>(value: [])
    
    init() {
        itemsRanking.accept(mapAddModelsToDInfoComicModels(addModels: getData()))
    }
    
    func getData() -> [AddModel] {
        let sortDesc = SortItem(byKeyPath: "avgRating", ascending: false)
        return RealmHelper.get(AddModel.self, sort: sortDesc)
    }
    
    func mapAddModelsToDInfoComicModels(addModels: [AddModel]) -> [InfoComicModel] {
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
}
