//
//  Model.swift
//  ComicVN
//
//  Created by Tuấn on 6/3/25.
//
import UIKit
import RealmSwift

struct DetailComicModel {
    let image: URL?
    let name: String?
    let rating: Double?
    let describe: [DescribeModel]
    let chapter: [ChapterModel]
}

struct DescribeModel {
    var title: String
    var value: String
}

struct ChapterModel {
    var title: String
    var url: URL
}

class BookmarkRealmModel: Object {
    @objc dynamic var userId: String?
    @objc dynamic var image: Data?
    @objc dynamic var name: String?
    @objc dynamic var author: String?
    @objc dynamic var category: String?
    @objc dynamic var totalChapter: Int = 0
}

// MARK: - Welcome
struct WelcomeDetailComic: Codable {
    let status, message: String
    let data: DataClassDetailComic
}

// MARK: - DataClass
struct DataClassDetailComic: Codable {
    let seoOnPage: SEOOnPageDetailComic
    let breadCrumb: [BreadCrumbDetailComic]
    let params: ParamsDetailComic
    let item: ItemDetailComic
    let APP_DOMAIN_CDN_IMAGE: String
}

// MARK: - BreadCrumb
struct BreadCrumbDetailComic: Codable {
    let name: String
    let slug: String?
    let position: Int
    let isCurrent: Bool?
}

// MARK: - Item
struct ItemDetailComic: Codable {
    let _id, name, slug: String?
    let origin_name: [String]?
    let content, status, thumb_url: String?
    let sub_docquyen: Bool?
    let author: [String]?
    let category: [CategoryDetailComic]?
    let chapters: [ChapterDetailComic]?
    let updatedAt: String?
}

// MARK: - Category
struct CategoryDetailComic: Codable {
    let id, name, slug: String
}

// MARK: - Chapter
struct ChapterDetailComic: Codable {
    let server_name: String
    let server_data: [ServerDataDetailComic]
}

// MARK: - ServerDatum
struct ServerDataDetailComic: Codable {
    let filename: String
    let chapter_name, chapter_title: String
    let chapter_api_data: String
}

// MARK: - Params
struct ParamsDetailComic: Codable {
    let slug, crawl_check_url: String
}

// MARK: - SEOOnPage
struct SEOOnPageDetailComic: Codable {
    let og_type, titleHead: String
    let seoSchema: SEOSchemaDetailComic?
    let descriptionHead: String
    let og_image: [String]
    let updated_time: Int
    let og_url: String
}

// MARK: - SEOSchema
struct SEOSchemaDetailComic: Codable {
    let context: String?
    let type, name: String?
    let url: String?
    let image: String?
    let director: String?
}

