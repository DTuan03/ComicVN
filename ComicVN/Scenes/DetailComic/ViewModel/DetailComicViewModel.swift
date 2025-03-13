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
    
    func fetchDetailComic(for slug: String) {
        let urlString = "https://otruyenapi.com/v1/api/truyen-tranh/\(slug)"
        
        DispatchQueue.global(qos: .background).async {
            APIHelper.fetchData(urlString: urlString, method: "GET", parameters: nil) { [weak self] (result: Result<WelcomeDetailComic, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    let mappedItems = self.mapItemToDetailComicModel(itemModel: response.data.item)
                    self.itemDetailComics.accept(mappedItems)
                case .failure(let error):
                    print("Lỗi khi gọi API: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func mapItemToDetailComicModel(itemModel: ItemDetailComic) -> DetailComicModel {
        let urlImage = "https://img.otruyenapi.com/uploads/comics/" + (itemModel.thumb_url ?? "")
        let describe: [DescribeModel] = [
            .init(title: "Lượt xem", value: "Đang cập nhật"),
            .init(title: "Số chương", value: String(itemModel.chapters?[0].server_data.count ?? 0)),
            .init(title: "Tác giả", value: itemModel.author?[0] ?? ""),
            .init(title: "Thể loại", value: itemModel.category?[0].name ?? "Đang cập nhật"),
            .init(title: "Trạng thái", value: itemModel.status ?? "Đang cập nhật"),
            .init(title: "Tóm tắt", value: ""),
            .init(title: "", value: itemModel.content ?? "")
        ]
        let chapter = createChapterModels(from: itemModel)
        return DetailComicModel(
            image: urlImage,
            name: itemModel.name,
            rating: 4,
            describe: describe,
            chapter: chapter ?? []
        )
    }
    
    private func createChapterModels(from itemsModel: ItemDetailComic) -> [ChapterModel]? {
        guard let chapters = itemsModel.chapters else { return nil }
        return chapters.flatMap { chapterDetail in
            return chapterDetail.server_data.map { serverData in
                return ChapterModel(title: serverData.chapter_name,
                                    url: serverData.chapter_api_data)
            }
        }
    }
    
    func checkedBookmark(userId: String, slug: String) -> Bool {
        let predicate = NSPredicate(format: "userId == %@ AND slug == %@", userId, slug)
        let comic = RealmHelper.getOne(BookmarkRealmModel.self, filter: predicate)
        if comic != nil {
            return true
        } else {
            return false
        }
    }
    
    func sortDescChapter() {
        if let sortedChapters = itemDetailComics.value?.chapter.sorted(by: { (Double($0.title) ?? 0.0) > (Double($1.title) ?? 0.0) }) {
            var updatedComic = itemDetailComics.value
            updatedComic?.chapter = sortedChapters
            self.itemDetailComics.accept(updatedComic)
        }
    }
    
    func sortAscChapter() {
        if let sortedChapters = itemDetailComics.value?.chapter.sorted(by: { (Double($0.title) ?? 0.0) < (Double($1.title) ?? 0.0) }) {
            var updatedComic = itemDetailComics.value
            updatedComic?.chapter = sortedChapters
            self.itemDetailComics.accept(updatedComic)
        }
    }
    
    func saveBookmarkComic(for model: BookmarkRealmModel) {
        RealmHelper.set(model)
    }
    
    func deleteBookmarkComic(userId: String, slug: String) {
        let predicate = NSPredicate(format: "userId == %@ AND slug == %@", userId, slug)
        RealmHelper.remove(BookmarkRealmModel.self, filter: predicate)
    }
}
