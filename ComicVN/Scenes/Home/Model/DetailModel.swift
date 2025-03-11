//
//  DetailModel.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit

struct DetailModel {
    let image: URL?
    let name: String?
    let rating: Double?
    let author: String?
    let category: String?
    let views: String?
    let slug: String?
}

struct ListModel {
    let image: UIImage?
    let title: String
    let hastag: String
}
// MARK: - Welcome
struct WelcomeHome: Codable  {
    let status, message: String
    let data: DataClassHome
}

// MARK: - DataClass
struct DataClassHome: Codable  {
    let seoOnPage: SEOOnPage
    let breadCrumb: [BreadCrumb]?
    let titlePage: String?
    let items: [Item]
    let params: Params
    let type_list: String?
    let APP_DOMAIN_FRONTEND, APP_DOMAIN_CDN_IMAGE: String
}

// MARK: - SEOOnPage
struct SEOOnPage: Codable  {
    let titleHead, descriptionHead, og_type: String
    let og_url: String?
    let og_image: [String]
}

// MARK: - BreadCrumb
struct BreadCrumb: Codable {
    let name: String
    let slug: String?
    let isCurrent: Bool
    let position: Int
}

// MARK: - Item
struct Item: Codable  {
    let _id, name, slug: String?
    let origin_name: [String]?
    let status: String?
    let thumb_url: String?
    let sub_docquyen: Bool?
    let category: [Category]?
    let updatedAt: String?
    let chaptersLatest: [ChaptersLatest]?
}

// MARK: - Category
struct Category: Codable  {
    let id, name, slug: String?
}

// MARK: - ChaptersLatest
struct ChaptersLatest: Codable  {
    let filename, chapter_name, chapter_title: String
    let chapter_api_data: String
}

// MARK: - Params
struct Params: Codable  {
    let type_slug: String
    let filterCategory: [String]
    let sortField: String?
    var sortType: String?
    let pagination: Pagination
    let itemsUpdateInDay: Int?
}

// MARK: - Pagination
struct Pagination: Codable  {
    let totalItems, totalItemsPerPage, currentPage, pageRanges: Int
}
