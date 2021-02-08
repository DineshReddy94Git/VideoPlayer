//
//  VideoListModel.swift
//  DemoProject
//
//  Created by K12 Services on 02/01/21.
//

import Foundation
struct VideoListModel : Codable {
    let description : String?
    let id : String?
    let thumb : String?
    let title : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case description = "description"
        case id = "id"
        case thumb = "thumb"
        case title = "title"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
