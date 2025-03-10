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
    var itemDetailComics = BehaviorRelay<DetailComicModel?>(value: nil)
    let disposeBag = DisposeBag()
    
    func fetchDetailComic(for type: String) {
        let urlString = "https://otruyenapi.com/v1/api/truyen-tranh/\(type)"
        
        DispatchQueue.global(qos: .background).async {
            APIHelper.fetchData(urlString: urlString, method: "GET", parameters: nil) { [weak self] (result: Result<WelcomeHome, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
//                    let mappedItems = self.mapItemsToTopComicModels(itemModels: response.data.items)
                    
                    DispatchQueue.main.async {
//                        self.iteitemDetailComicsms.accept(mappedItems)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func mapItemToDetailComicModel(itemsModel: ItemDetailComic) -> DetailComicModel {
        let urlImage = URL(string: "https://img.otruyenapi.com/uploads/comics/" + (itemsModel.thumb_url ?? ""))
        let chapter = itemsModel.chapters
    }
    
    func mapItemsToTopComicModels(itemModels: [Item]) -> [TopComicModel] {
        return itemModels.map { mapItemToTopComicModel(itemsModel: $0) }
    }
}
