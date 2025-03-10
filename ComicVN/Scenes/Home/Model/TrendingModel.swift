//
//  TrendingModel.swift
//  ComicVN
//
//  Created by Tuấn on 9/3/25.
//
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcome {
//    let status, message: String
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass {
//    let seoOnPage: SEOOnPage
//    let breadCrumb: [BreadCrumb]
//    let titlePage: String
//    let items: [Item]
//    let params: Params
//    let typeList: String
//    let appDomainFrontend, appDomainCDNImage: String
//}
//
//// MARK: - BreadCrumb
//struct BreadCrumb {
//    let name: String
//    let slug: String?
//    let isCurrent: Bool
//    let position: Int
//}
//
//// MARK: - Item
//struct Item {
//    let id, name, slug: String
//    let originName: [String]
//    let status: Status
//    let thumbURL: String
//    let subDocquyen: Bool
//    let category: [Category]
//    let updatedAt: String
//    let chaptersLatest: [ChaptersLatest]
//}
//
//// MARK: - Category
//struct Category {
//    let id, name, slug: String
//}
//
//// MARK: - ChaptersLatest
//struct ChaptersLatest {
//    let filename, chapterName, chapterTitle: String
//    let chapterAPIData: String
//}
//
//enum Status: String {
//    case comingSoon
//    case ongoing
//}
//
//// MARK: - Params
//struct Params {
//    let typeSlug: String
//    let filterCategory: [String]
//    let sortField, sortType: String
//    let pagination: Pagination
//}
//
//// MARK: - Pagination
//struct Pagination {
//    let totalItems, totalItemsPerPage, currentPage, pageRanges: Int
//}
//
//// MARK: - SEOOnPage
//struct SEOOnPage {
//    let ogType, titleHead, descriptionHead: String
//    let ogImage: [String]
//    let ogURL: String
//}
