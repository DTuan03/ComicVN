//
//  DetailViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import RxSwift
import RxCocoa
import RealmSwift

class DetailViewModel {
    let itemsDetail = BehaviorRelay<[DetailModel]>(value: [])
    let itemsTrending = BehaviorRelay<[DetailModel]>(value: [])
    let itemsNewComic = BehaviorRelay<[DetailModel]>(value: [])
    let itemsCategory = BehaviorRelay<[ListModel]>(value: [])

    
    init() {
        let categoryData = [
            ListModel(image: UIImage(named: "topTruyen"), title: "TOP TRUYỆN", hastag: "#TRUYỆN HAY"),
            ListModel(image: UIImage(named: "xepHang"), title: "XẾP HẠNG", hastag: "#ĐỌC NHIỀU NHẤT"),
            ListModel(image: UIImage(named: "theLoai"), title: "THỂ LOẠI", hastag: "#CHUYÊN MỤC"),
            ListModel(image: UIImage(named: "bookMark"), title: "BOOK MARK", hastag: "#TRUYỆN CỦA BẠN"),
        ]
        itemsDetail.accept(mapAddModelsToDetailModels(addModels: getDetailData()))
        itemsTrending.accept(mapAddModelsToDetailModels(addModels: getTrendingData()))
        itemsNewComic.accept(mapAddModelsToDetailModels(addModels: getNewComicData()))
        itemsCategory.accept(categoryData)
    }
    
    func getDetailData() -> [AddModel] {
        return RealmHelper.get(AddModel.self)
    }
    
    func getTrendingData() -> [AddModel] {
        let predicate = NSPredicate(format: "isTrending == %@", NSNumber(value: true))
        return RealmHelper.get(AddModel.self, filter: predicate)
    }
    
    func getNewComicData() -> [AddModel] {
        let predicate = NSPredicate(format: "isNewComic == %@", NSNumber(value: true))
        return RealmHelper.get(AddModel.self, filter: predicate)
    }
    
    func mapAddModelsToDetailModels(addModels: [AddModel]) -> [DetailModel] {
        return addModels.map { mapAddModelToDetailModel(addModel: $0) }
    }
    
    func mapAddModelToDetailModel(addModel: AddModel) -> DetailModel {
        return DetailModel(
            image: UIImage(data: addModel.image ?? Data()),
            name: addModel.name,
            rating: Double(addModel.avgRating),
            author: addModel.author,
            category: addModel.category,
            views: addModel.views
        )
    }
}
