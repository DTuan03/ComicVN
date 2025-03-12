//
//  TopComicViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//

import RxSwift
import RxCocoa
import RealmSwift

class TopComicViewModel {
    var items = BehaviorRelay<([TopComicModel])>(value: ([]))
    var selectedSegment = BehaviorRelay<Int>(value: 0)
    let disposeBag = DisposeBag()
    
    init() {
        setupBinding()
    }
    
    func fetchTopComics(for type: String) {
        let urlString = "https://otruyenapi.com/v1/api/danh-sach/hoan-thanh?page=\(type)"
        
        DispatchQueue.global(qos: .background).async {
            APIHelper.fetchData(urlString: urlString, method: "GET", parameters: nil) { [weak self] (result: Result<WelcomeHome, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    let mappedItems = self.mapItemsToTopComicModels(itemModels: response.data.items)
                    
                    DispatchQueue.main.async {
                        self.items.accept(mappedItems)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func mapItemToTopComicModel(itemsModel: Item) -> TopComicModel {
        let urlImage = URL(string: "https://img.otruyenapi.com/uploads/comics/" + (itemsModel.thumb_url ?? ""))
        return TopComicModel(
            avatar: urlImage,
            name: itemsModel.name,
            rating: 4,
            author: "Đang cập nhật",
            category: itemsModel.category?[0].name ?? "Đang cập nhật",
            views: "Đang cập nhật"
        )
    }
    
    func mapItemsToTopComicModels(itemModels: [Item]) -> [TopComicModel] {
        return itemModels.map { mapItemToTopComicModel(itemsModel: $0) }
    }
    
    func setupBinding() {
        selectedSegment
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                switch index {
                case 0:
                    self.fetchTopComics(for: "2")
                case 1:
                    self.fetchTopComics(for: "3")
                case 2:
                    self.fetchTopComics(for: "4")
                default:
                    self.items.accept([])
                }
            })
            .disposed(by: disposeBag)
    }
}
