//
//  NewSources.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 21.09.2023.
//

import Foundation

public struct NewsSource: Decodable, Hashable {
    let id: String?
    let name: String?
    let category: String?
}

public struct AllNewsSources: Decodable {
    let sources: [NewsSource]
}
