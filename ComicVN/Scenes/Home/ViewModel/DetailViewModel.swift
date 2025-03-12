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
        featchDetail()
        featchTrending()
        featchNewComic()
        itemsCategory.accept(categoryData)
    }
    
    func featchDetail() {
        DispatchQueue.main.async {
            APIHelper.fetchData(urlString: "https://otruyenapi.com/v1/api/danh-sach/truyen-moi?page=2", method: "GET", parameters: nil) { (result: Result<WelcomeHome, Error>) in
                switch result {
                case .success(let response):
                    let items = self.mapItemsToDetailModels(itemModels: response.data.items)
                    DispatchQueue.main.async {
                        self.itemsDetail.accept(items)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func featchTrending() {
        DispatchQueue.main.async {
            APIHelper.fetchData(urlString: "https://otruyenapi.com/v1/api/danh-sach/hoan-thanh?page=1", method: "GET", parameters: nil) { (result: Result<WelcomeHome, Error>) in
                switch result {
                case .success(let response):
                    let items = self.mapItemsToDetailModels(itemModels: response.data.items)
                    DispatchQueue.main.async {
                        self.itemsTrending.accept(items)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func featchNewComic() {
        DispatchQueue.main.async {
            APIHelper.fetchData(urlString: "https://otruyenapi.com/v1/api/danh-sach/truyen-moi?page=1", method: "GET", parameters: nil) { (result: Result<WelcomeHome, Error>) in
                switch result {
                case .success(let response):
                    let items = self.mapItemsToDetailModels(itemModels: response.data.items)
                    DispatchQueue.main.async {
                        self.itemsNewComic.accept(items)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func mapItemToDetailModel(itemsModel: Item) -> DetailModel {
        let urlImage = URL(string: "https://img.otruyenapi.com/uploads/comics/" + (itemsModel.thumb_url ?? ""))
        return DetailModel(
            image: urlImage,
            name: itemsModel.name,
            rating: 4,
            author: "Đang cập nhật",
            category: itemsModel.category?[0].name ?? "Đang cập nhật",
            views: "Đang cập nhật",
            slug: itemsModel.slug
        )
    }
    
    func mapItemsToDetailModels(itemModels: [Item]) -> [DetailModel] {
        return itemModels.map { mapItemToDetailModel(itemsModel: $0) }
    }
}

