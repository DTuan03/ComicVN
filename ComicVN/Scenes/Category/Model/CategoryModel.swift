//
//  CategoryModel.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//

struct CategoryModel {
    let name: String?
    let number: String?
    let slug: String?
}

// MARK: - Welcome
struct WelcomeCategory: Codable {
    let status, message: String
    let data: DataClassCategory
}

// MARK: - DataClass
struct DataClassCategory:Codable {
    let items: [ItemCategory]
}

// MARK: - Item
struct ItemCategory: Codable {
    let _id, slug, name: String
}
