//
//  ReadComicModel.swift
//  ComicVN
//
//  Created by Tuấn on 10/3/25.
//

struct ReadComicModel {
    
}

// MARK: - Welcome
struct WelcomeReadComic {
    let status, message: String
    let data: DataClassReadComic
}

// MARK: - DataClass
struct DataClassReadComic {
    let domain_cdn: String
    let item: Item
}

// MARK: - Item
struct ItemReadComic {
    let _id, comic_name, chapter_name, chapter_title: String
    let chapter_path: String
    let chapter_image: [ChapterImageReadComic]
}

// MARK: - ChapterImage
struct ChapterImageReadComic {
    let image_page: Int
    let image_file: String
}
