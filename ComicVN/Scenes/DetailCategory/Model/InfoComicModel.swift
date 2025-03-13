//
//  InfoComicModel.swift
//  ComicVN
//
//  Created by Tuấn on 28/2/25.
//
import UIKit

struct InfoComicModel {
    let avatar: URL?
    let name: String?
    let rating: Double?
    let author: String?
    let category: String?
    let views: String?
    let slug: String?
}

// MARK: - Welcome
struct WelcomeInfoComic: Codable {
    let status, message: String
    let data: DataClassInfoComic
}

// MARK: - DataClass
struct DataClassInfoComic: Codable {
    let seoOnPage: SEOOnPageInfoComic
    let breadCrumb: [BreadCrumbInfoComic]
    let titlePage: String?
    let items: [ItemInfoComic]
    let params: ParamsInfoComic
    let type_list: String?
    let APP_DOMAIN_FRONTEND, APP_DOMAIN_CDN_IMAGE: String
}

// MARK: - BreadCrumb
struct BreadCrumbInfoComic: Codable {
    let name: String
    let slug: String?
    let isCurrent: Bool
    let position: Int
}

// MARK: - Item
struct ItemInfoComic: Codable {
    let _id, name, slug: String
    let origin_name: [String]
    let status: String
    let thumb_url: String
    let sub_docquyen: Bool
    let category: [CategoryInfoComic]
    let updatedAt: String
    let chaptersLatest: [ChaptersLatestInfoComic]?
}

// MARK: - Category
struct CategoryInfoComic: Codable {
    let id, name, slug: String
}

// MARK: - ChaptersLatest
struct ChaptersLatestInfoComic: Codable {
    let filename, chapter_name: String
    let chapter_title: String
    let chapter_api_data: String
}

// MARK: - Params
struct ParamsInfoComic: Codable {
    let type_slug, slug: String
    let filterCategory: [String]
    let sortField, sortType: String
    let pagination: PaginationInfoComic
}

// MARK: - Pagination
struct PaginationInfoComic: Codable {
    let totalItems, totalItemsPerPage, currentPage, pageRanges: Int
}

// MARK: - SEOOnPage
struct SEOOnPageInfoComic: Codable {
    let og_type, titleHead: String?
    let og_image: [String]
    let og_url: String
}
