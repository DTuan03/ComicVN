//
//  CategoryViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import RxSwift
import RxCocoa
import RealmSwift

class CategoryViewModel {
    let itemsCategory = BehaviorRelay<[CategoryModel]>(value: [])
    
    init() {
        itemsCategory.accept(mapAddModelsToCategoryModels(addModels: getData()))
    }
    
    func getData() -> [AddModel] {
        return RealmHelper.get(AddModel.self)
    }
    
    func mapAddModelsToCategoryModels(addModels: [AddModel]) -> [CategoryModel] {
        let categoryCounts = addModels.reduce(into: [String: Int]()) { (countDict, item) in
            countDict[item.category, default: 0] += 1
        }
        
        let categoryModels = categoryCounts.map { (name, count) in
            CategoryModel(name: name, number: "\(count)")
        }
        
        return categoryModels
    }
    
    func mapAddModelToNameCategory(addModel: AddModel) -> String {
        return addModel.category
    }
    
    func getNameCategory(indexPath: IndexPath) -> String {
        return itemsCategory.value[indexPath.item].name
    }
}
