//
//  DetailComicViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 6/3/25.
//

import RxSwift
import RxCocoa
import RealmSwift

class DetailComicViewModel {
    var itemDetailComics = BehaviorRelay<DetailComicModel>(value: DetailComicModel(image: .test, name: "Iron Man: Extremis", rating: 4))
    let disposeBag = DisposeBag()
//    init(
//
//    )
//    
    func getData(name: String) -> AddModel {
        let predicate = NSPredicate(format: "name == %@", name)
        return RealmHelper.getOne(AddModel.self, filter: predicate) ?? AddModel()
    }

    func mapAddModelToDetailComicModel(addModel: AddModel) -> DetailComicModel {
        return DetailComicModel(
            image: UIImage(data: addModel.image ?? Data()),
            name: addModel.name,
            rating: Double(addModel.avgRating)
        )
    }
}
