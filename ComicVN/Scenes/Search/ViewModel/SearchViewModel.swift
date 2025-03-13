//
//  SearchViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 12/3/25.
//

//https://otruyenapi.com/v1/api/tim-kiem?keyword=t
import RxSwift
import RxCocoa
import RealmSwift

class SearchViewModel {
    let itemsSearch = BehaviorRelay<[SearchModel]>(value: [])
    let itemFilter = BehaviorRelay<[FilterModel]>(value: [])
    private let disposeBag = DisposeBag()
    
    func fetchItems(for value: String) {
        DispatchQueue.global(qos: .background).async {
            APIHelper.fetchData(urlString: "https://otruyenapi.com/v1/api/tim-kiem?keyword=\(value)" , method: "GET", parameters: nil) { [weak self] (result: Result<WelcomeSearch, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    let items = self.mapItemsToSearchModels(itemModels: response.data.items)
                    let category = self.filter(items: items)
                    DispatchQueue.main.async {
                        self.itemsSearch.accept(items)
                        self.itemFilter.accept(category)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func mapItemToSearchModel(itemsModel: ItemSearch) -> SearchModel {
        return SearchModel(
            avatar: "https://img.otruyenapi.com/uploads/comics/" + itemsModel.thumb_url,
            name: itemsModel.name,
            author: itemsModel.author[0],
            category: itemsModel.category[0].name,
            totalChapter: String(itemsModel.chapters[0].server_data.count),
            slug: itemsModel.slug
        )
    }

    func mapItemsToSearchModels(itemModels: [ItemSearch]) -> [SearchModel] {
        return itemModels.map { mapItemToSearchModel(itemsModel: $0) }
    }
    
    func filter(items: [SearchModel]) -> [FilterModel] {
        let categories = Set(items.map { $0.category })
        return categories.map { FilterModel(category: $0) }
    }
}
