//
//  Article.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 12.09.2023.
//

import Foundation

public struct ArticleList: Decodable{
    public var articles: [Article]
}

public struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    var content: String?
    let publishedAt: String?
}

public struct Source : Codable {
    let id: String?
    let name: String?
}

