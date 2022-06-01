//
//  ArticlesListModel.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 28/05/22.
//

import Foundation

struct ArticlesListModel : Codable {
    let status : String?
    let totalResults : Int?
    let articles : [Articles]?

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        articles = try values.decodeIfPresent([Articles].self, forKey: .articles)
    }
}
