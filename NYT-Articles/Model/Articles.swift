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
    private let nonImageUrl = "https://elasticbeanstalk-eu-west-1-805589474796.s3-eu-west-1.amazonaws.com/no-image-found-360x260.png"
    var imageURL: String {
        if media.count != 0 {
            if media[0].mediaMetadata.count > 2 {
                return media[0].mediaMetadata[2].url

            } else {
                return nonImageUrl
            }
        } else {
            return nonImageUrl
        }
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

