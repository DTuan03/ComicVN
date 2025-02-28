//
//  MenuViewModel.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

import Foundation

struct MenuSection {
    var items: [MenuItem]
}

class MenuViewModel {
    
    var menuSections: [MenuSection] = [
        MenuSection(items: [
            MenuItem(title: "Trang chủ", iconName: "house.fill", action: .home, isSelected: true),
            MenuItem(title: "Thể loại", iconName: "list.bullet", action: .categories, isSelected: false),
            MenuItem(title: "Top truyện", iconName: "star.fill", action: .topComics, isSelected: false),
            MenuItem(title: "Xếp hạng", iconName: "trophy.fill", action: .rankings, isSelected: false),
            MenuItem(title: "Bookmark", iconName: "book.fill", action: .bookmark, isSelected: false),
            MenuItem(title: "Cài đặt", iconName: "gearshape.fill", action: .settings, isSelected: false)
        ]),
        
        MenuSection(items: [
            MenuItem(title: "Đánh giá 5 sao", iconName: "star.fill", action: .rateApp, isSelected: false),
            MenuItem(title: "Gửi phản hồi", iconName: "bubble.left.fill", action: .sendFeedback, isSelected: false),
            MenuItem(title: "Chính sách bảo mật", iconName: "lock.fill", action: .privacyPolicy, isSelected: false)
        ])
    ]
    
    func numberOfSections() -> Int {
        return menuSections.count
    }
    
    func numberOfItems(in section: Int) -> Int {
        return menuSections[section].items.count
    }
    
    func item(at indexPath: IndexPath) -> MenuItem {
        return menuSections[indexPath.section].items[indexPath.row]
    }
    
    func selectItem(at indexPath: IndexPath) {
        for sectionIndex in 0..<menuSections.count {
            for itemIndex in 0..<menuSections[sectionIndex].items.count {
                menuSections[sectionIndex].items[itemIndex].isSelected = false
            }
        }
        menuSections[indexPath.section].items[indexPath.row].isSelected = true
    }
}
