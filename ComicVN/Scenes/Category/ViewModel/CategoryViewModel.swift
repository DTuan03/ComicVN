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
    private let disposeBag = DisposeBag()

    init() {
        fetchCategory()
    }

    func fetchCategory() {
        DispatchQueue.global(qos: .background).async {
            APIHelper.fetchData(urlString: "https://otruyenapi.com/v1/api/the-loai", method: "GET", parameters: nil) { [weak self] (result: Result<WelcomeCategory, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    let items = self.mapItemsToCategoryModels(itemModels: response.data.items)
                    DispatchQueue.main.async {
                        self.itemsCategory.accept(items)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }

    func mapItemToCategoryModel(itemsModel: ItemCategory) -> CategoryModel {
        return CategoryModel(
            name: itemsModel.name,
            number: "Đang cập nhật",
            slug: itemsModel.slug
        )
    }

    func mapItemsToCategoryModels(itemModels: [ItemCategory]) -> [CategoryModel] {
        return itemModels.map { mapItemToCategoryModel(itemsModel: $0) }
    }
}
