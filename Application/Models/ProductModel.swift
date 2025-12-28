//
//  ProductModel.swift
//  Application
//
//  Created by Ganpat Jangir on 27/12/25.
//

import Foundation

struct ProductAPIResponseModel : Codable {
    let data : [ProductModel]?
    let pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case pagination = "pagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ProductModel].self, forKey: .data)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }
}

struct ProductModel : Codable {
    let id : Int?
    let title : String?
    let price : Double?
    let description : String?
    let category : String?
    let brand : String?
    let stock : Int?
    let image : String?
    let specs : ProductSpecificationsModel?
    let rating : ProductRatingModel?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case brand = "brand"
        case stock = "stock"
        case image = "image"
        case specs = "specs"
        case rating = "rating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        stock = try values.decodeIfPresent(Int.self, forKey: .stock)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        specs = try values.decodeIfPresent(ProductSpecificationsModel.self, forKey: .specs)
        rating = try values.decodeIfPresent(ProductRatingModel.self, forKey: .rating)
    }

}

struct ProductSpecificationsModel : Codable {
    let color : String?
    let weight : String?
    let storage : String?

    enum CodingKeys: String, CodingKey {

        case color = "color"
        case weight = "weight"
        case storage = "storage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        storage = try values.decodeIfPresent(String.self, forKey: .storage)
    }

}

struct ProductRatingModel : Codable {
    let rate : Double?
    let count : Int?

    enum CodingKeys: String, CodingKey {

        case rate = "rate"
        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
    }

}

struct Pagination : Codable {
    let page : Int?
    let limit : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case limit = "limit"
        case total = "total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}
