//
//  SearchModel.swift
//  ComicVN
//
//  Created by Tuấn on 12/3/25.
//
import Foundation

struct SearchModel {
    let avatar: String?
    let name: String?
    let author: String?
    let category: String?
    let totalChapter: String?
    let slug: String?
}

// MARK: - Welcome
struct WelcomeSearch: Codable {
    let status, message: String
    let data: DataClassSearch
}

// MARK: - DataClass
struct DataClassSearch: Codable {
    let seoOnPage: SEOOnPageSearch
    let breadCrumb: [BreadCrumbSearch]
    let titlePage: String
    let items: [ItemSearch]
    let params: ParamsSearch
    let type_list: String
    let APP_DOMAIN_FRONTEND, APP_DOMAIN_CDN_IMAGE: String
}

// MARK: - BreadCrumb
struct BreadCrumbSearch: Codable {
    let name: String
    let isCurrent: Bool
    let position: Int
}

// MARK: - Item
struct ItemSearch: Codable {
    let name, slug: String
    let origin_name: [String]
    let status: String
    let thumb_url: String
    let sub_docquyen: Bool
    let author: [String]
    let category: [CategorySearch]
    let chapters: [ChapterSearch]
    let updatedAt: String
    let chaptersLatest: [ChaptersLatestSearch]
}

// MARK: - Category
struct CategorySearch: Codable {
    let id, name, slug: String
}

// MARK: - Chapter
struct ChapterSearch: Codable {
    let server_name: String
    let server_data: [ChaptersLatestSearch]
}

// MARK: - ChaptersLatest
struct ChaptersLatestSearch: Codable {
    let filename, chapter_name, chapter_title: String
    let chapter_api_data: String
}

// MARK: - Params
struct ParamsSearch: Codable {
    let type_slug, keyword: String
    let filterCategory: [String]
    let sortField, sortType: String
    let pagination: PaginationSearch
}

// MARK: - Pagination
struct PaginationSearch: Codable {
    let totalItems, totalItemsPerPage, currentPage, pageRanges: Int
}

// MARK: - SEOOnPage
struct SEOOnPageSearch: Codable {
    let og_type, titleHead, descriptionHead: String
    let og_image: [String]
    let og_url: String
}
