//
//  ReadComicModel.swift
//  ComicVN
//
//  Created by Tuấn on 10/3/25.
//
import Foundation

struct ReadComicModel {
    let image: [String]
}

// MARK: - Welcome
struct WelcomeReadComic: Codable {
    let status, message: String
    let data: DataClassReadComic
}

// MARK: - DataClass
struct DataClassReadComic: Codable {
    let domain_cdn: String
    let item: ItemReadComic
}

// MARK: - Item
struct ItemReadComic: Codable {
    let _id, comic_name, chapter_name, chapter_title: String
    let chapter_path: String
    let chapter_image: [ChapterImageReadComic]
}

// MARK: - ChapterImage
struct ChapterImageReadComic: Codable {
    let image_page: Int
    let image_file: String
}
