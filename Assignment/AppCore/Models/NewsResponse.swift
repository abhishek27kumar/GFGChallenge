//
//  NewsResponse.swift
//  Assignment
//
//  Created by Abhishek on 17/08/21.
//

import Foundation


struct NewsResponse : Decodable
{
    let status: String?
    let newsFeed: Feed?
    let newsItems: [NewsItems]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case newsFeed = "feed"
        case newsItems = "items"
    }
}

struct Feed: Decodable {
    let url, title, link, author, description, image: String?
    
}

struct NewsItems: Decodable {
    let title, pubDate, link, guid, author, thumbnail, description, content: String?
    let enclosure: NewsItemEnclosure?
    let categories: [String]?
}

struct NewsItemEnclosure: Decodable {
    let link, type, thumbnail: String?
}
