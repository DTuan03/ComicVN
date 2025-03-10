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
    func fetchTopComics(for type: String) {
        print(type)
        let urlString = "https://otruyenapi.com/v1/api/the-loai/\(type)?page=2"
        
        DispatchQueue.global(qos: .background).async {
            APIHelper.fetchData(urlString: urlString, method: "GET", parameters: nil) { [weak self] (result: Result<WelcomeInfoComic, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    let mappedItems = self.mapItemsToInfoComicModels(itemModels: response.data.items)
                    
                    DispatchQueue.main.async {
                        self.itemsInfoComic.accept(mappedItems)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func mapItemsToInfoComicModels(itemModels: [ItemInfoComic]) -> [InfoComicModel] {
        return itemModels.map { mapItemToInfoComicModel(itemModel: $0) }
    }

    func mapItemToInfoComicModel(itemModel: ItemInfoComic) -> InfoComicModel {
        let urlImage = URL(string: "https://img.otruyenapi.com/uploads/comics/" + (itemModel.thumb_url))
        return InfoComicModel(
            avatar: urlImage,
            name: itemModel.name,
            rating: 5,
            author: "Đang cập nhật",
            category: itemModel.category[0].name,
            views: "Đang cập nhật"
           
        )
    }
}
