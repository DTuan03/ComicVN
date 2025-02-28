//
//  MenuModel.swift
//  ComicVN
//
//  Created by Tuấn on 27/2/25.
//

struct MenuItem {
    let title: String
    let iconName: String
    let action: MenuAction
    var isSelected: Bool
}

enum MenuAction {
    case home
    case categories
    case topComics
    case rankings
    case bookmark
    case settings
    case rateApp
    case sendFeedback
    case privacyPolicy
}
