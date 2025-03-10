//
//  TopComicModel.swift
//  ComicVN
//
//  Created by Tuấn on 1/3/25.
//
import UIKit

struct TopComicModel {
    let avatar: URL?
    let name: String?
    let rating: Double?
    let author: String?
    let category: String?
    let views: String?
}

// MARK: - Welcome
struct WelcomeTopComic: Codable  {
    let status, message: String
    let data: DataClassTopComic
}

// MARK: - DataClass
struct DataClassTopComic: Codable  {
    let seoOnPage: SEOOnPageTopComic
    let breadCrumb: [BreadCrumbTopComic]?
    let titlePage: String?
    let items: [Item]
    let params: ParamsTopComic
    let type_list: String?
    let APP_DOMAIN_FRONTEND, APP_DOMAIN_CDN_IMAGE: String
}

// MARK: - SEOOnPage
struct SEOOnPageTopComic: Codable  {
    let titleHead, descriptionHead, og_type: String
    let og_url: String?
    let og_image: [String]
}

// MARK: - BreadCrumb
struct BreadCrumbTopComic: Codable {
    let name: String
    let slug: String?
    let isCurrent: Bool
    let position: Int
}

// MARK: - Item
struct ItemTopComic: Codable  {
    let _id, name, slug: String?
    let origin_name: [String]?
    let status: String?
    let thumb_url: String?
    let sub_docquyen: Bool?
    let category: [CategoryTopComic]?
    let updatedAt: String?
    let chaptersLatest: [ChaptersLatestTopComic]?
}

// MARK: - Category
struct CategoryTopComic: Codable  {
    let id, name, slug: String?
}

// MARK: - ChaptersLatest
struct ChaptersLatestTopComic: Codable  {
    let filename, chapter_name, chapter_title: String
    let chapter_api_data: String
}

// MARK: - Params
struct ParamsTopComic: Codable  {
    let type_slug: String
    let filterCategory: [String]
    let sortField: String?
    var sortType: String?
    let pagination: PaginationTopComic
    let itemsUpdateInDay: Int?
}

// MARK: - Pagination
struct PaginationTopComic: Codable  {
    let totalItems, totalItemsPerPage, currentPage, pageRanges: Int
}
