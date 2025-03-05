//
//  AddViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 4/3/25.
//
import RxSwift
import RxCocoa
import RealmSwift

class AddViewModel {
    var imageData = BehaviorRelay<UIImage?>(value: nil)
    var name = BehaviorRelay<String>(value: "")
    var avgRating = BehaviorRelay<Int>(value: 3)
    var category = BehaviorRelay<String>(value: "")
    var author = BehaviorRelay<String>(value: "")
    var views = BehaviorRelay<String>(value: "")
    var totalChapter = BehaviorRelay<Int>(value: 0)
    var status = BehaviorRelay<Bool>(value: true)
    var summary = BehaviorRelay<String>(value: "")
    var isTrending = BehaviorRelay<Bool>(value: false)
    var isNewComic = BehaviorRelay<Bool>(value: false)
    var topWeak = BehaviorRelay<Bool>(value: false)
    var topMonth = BehaviorRelay<Bool>(value: false)
    var topReviews = BehaviorRelay<Bool>(value: false)

    func saveAddModelToRealm() {
        guard let image = imageData.value else {
            print("Ảnh chưa được chọn!")
            return
        }
        
        let newAddModel = AddModel()
        newAddModel.image = image.jpegData(compressionQuality: 1.0)
        newAddModel.name = name.value
        newAddModel.avgRating = avgRating.value
        newAddModel.category = category.value
        newAddModel.author = author.value
        newAddModel.views = views.value
        newAddModel.totalChapter = totalChapter.value
        newAddModel.status = status.value
        newAddModel.summary = summary.value
        newAddModel.isTrending = isTrending.value
        newAddModel.isNewComic = isNewComic.value
        newAddModel.topWeak = topWeak.value
        newAddModel.topMonth = topMonth.value
        newAddModel.topReviews = topReviews.value

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newAddModel, update: .modified)
            }
        } catch let error {
            print("Lỗi khi lưu dữ liệu vào Realm: \(error.localizedDescription)")
        }
    }
    
}
