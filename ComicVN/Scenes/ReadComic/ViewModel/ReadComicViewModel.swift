//
//  ReadComicViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 11/3/25.
//
import RxSwift
import RxCocoa

class ReadComicViewModel {
    var items = BehaviorRelay<ReadComicModel>(value: ReadComicModel(image: []))
    let disposeBag = DisposeBag()
    
    func fetchTopComics(for url: String) {
        let urlString = url
        
        DispatchQueue.global(qos: .background).async {
            APIHelper.fetchData(urlString: urlString, method: "GET", parameters: nil) { [weak self] (result: Result<WelcomeReadComic, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    let mappedItems = self.mapItemToReadComicModel(items: response.data.item)
                    
                    DispatchQueue.main.async {
                        self.items.accept(mappedItems)
                    }
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func mapItemToReadComicModel(items: ItemReadComic) -> ReadComicModel {
        var images: [String] = []
        for item in items.chapter_image {
            images.append("https://sv1.otruyencdn.com/" + items.chapter_path + "/" + item.image_file)
        }
        return ReadComicModel(image: images)
    }
}

