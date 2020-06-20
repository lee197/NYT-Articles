//
//  Articles.swift
//  NYT-Articles
//
//  Created by 李祺 on 19/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation


// MARK: - Articles
struct Articles: Decodable {
    let results: [ArticleResult]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct ArticleResult: Decodable {
    let url: String
    let section, subsection: String
    let title, abstract: String
    private let media: [Media]
    var imageURL: String {
        media[0].mediaMetadata[1].url
    }
}

// MARK: - Media
struct Media: Codable {
    let mediaMetadata: [MediaMetadatum]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String
}

