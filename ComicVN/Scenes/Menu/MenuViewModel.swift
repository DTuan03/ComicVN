//
//  MenuViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

import Foundation
import RxSwift
import RxCocoa

struct MenuSection {
    var items: [MenuItem]
}

class MenuViewModel {
    static let shared = MenuViewModel()
    let itemsMenu = BehaviorRelay<[MenuSection]>(value: [])
    
    var menuSections: [MenuSection] = [
        MenuSection(items: [
            MenuItem(title: "Trang chủ", iconName: "house.fill", action: .home),
            MenuItem(title: "Thể loại", iconName: "list.bullet", action: .categories),
            MenuItem(title: "Top truyện", iconName: "star.fill", action: .topComics),
            MenuItem(title: "Xếp hạng", iconName: "trophy.fill", action: .rankings),
            MenuItem(title: "Bookmark", iconName: "book.fill", action: .bookmark),
            MenuItem(title: "Cài đặt", iconName: "gearshape.fill", action: .settings)
        ]),
        MenuSection(items: [
            MenuItem(title: "Đánh giá 5 sao", iconName: "star.fill", action: .rateApp),
            MenuItem(title: "Gửi phản hồi", iconName: "bubble.left.fill", action: .sendFeedback),
            MenuItem(title: "Chính sách bảo mật", iconName: "lock.fill", action: .privacyPolicy)
        ])
    ]
    
    init() {
        itemsMenu.accept(menuSections)
    }
    
    func numberOfSections() -> Int {
        return menuSections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        return menuSections[section].items.count
    }
    
    func item(at indexPath: IndexPath) -> MenuItem {
        return menuSections[indexPath.section].items[indexPath.row]
    }
}
