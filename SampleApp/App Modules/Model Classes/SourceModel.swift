//
//  SourceModel.swift
//  SampleApp
//
//  Created by Abhishek Srivastava on 28/05/22.
//

import Foundation

struct Source : Codable {
    let id : String?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
