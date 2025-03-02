//
//  CategoryViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

import RxSwift
import RxCocoa

class CategoryViewModel {
    let itemsCategory = BehaviorRelay<[CategoryModel]>(value: [])
    
    
    init() {
        let exData = [
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
            CategoryModel(name: "Kiem hiep", number: "12233"),
        ]
        
        itemsCategory.accept(exData)
    }
}
