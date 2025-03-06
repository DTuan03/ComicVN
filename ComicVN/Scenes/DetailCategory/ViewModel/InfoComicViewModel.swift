//
//  InfoComicViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import RxSwift
import RxCocoa
import RealmSwift

class InfoComicViewModel {
    var itemsInfoComic = BehaviorRelay<[InfoComicModel]>(value: [])
    
//    init() {
//        itemsInfoComic.accept()
//    }
//    
    func getData(category: String) -> [AddModel] {
        let predicate = NSPredicate(format: "category == %@", category)
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
}
