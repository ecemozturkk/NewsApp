//
//  APICaller.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 12.09.2023.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Singleton
    static let shared = NetworkManager()
    
    // MARK: - Properties
    let urlSession = URLSession.shared
    let baseURL = "https://newsapi.org/v2/"
    let APIKEY = "51cfe807e03943b881d6f9642810cae0"
    
    // MARK: - EndPoints Enumeration
    enum EndPoints {
        case articles
        case category(categoryIn: String, pageNumber: String)
        case search(q: String)
        
        func getPath() -> String {
            switch self {
            case .articles, .category:
                return "top-headlines"
            case .search:
                return "everything"
            }
        }
        
        func HTTPRequestMethod() -> String {
            return "GET"
        }
        
        func getHeaders(apiKey: String) -> [String: String] {
            return [
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "X-Api-Key \(apiKey)",
                "Host": "newsapi.org"
            ]
        }
        
        func getParameters() -> [String: String] {
            switch self {
            case .articles:
                return ["country": "us"]
            case .category(let categoryIn, let pageNum):
                return ["country": "us",
                        "category": categoryIn,
                        "page": pageNum]
            case .search(let qInput):
                return ["q": qInput]
            }
        }
        
        func parametersToString() -> String {
            let parameterArray = getParameters().map { key, value in
                return "\(key)=\(value)"
            }
            return parameterArray.joined(separator: "&")
        }
    }
    
    // MARK: - Result Enumeration
    enum Result<T> {
        case success(T?)
        case failure(Error)
    }
    
    // MARK: - EndPointError Enumeration
    enum EndPointError: Error {
        case couldNotParse
        case noData
    }
    
    // MARK: - Private Methods
    private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let path = endPoint.getPath()
        let stringParams = endPoint.parametersToString()
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))
        var request = URLRequest(url: fullURL!)
        request.httpMethod = endPoint.HTTPRequestMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(apiKey: APIKEY)
        return request
    }
    
    // MARK: - Public Methods
    func getArticles(passedInCategory: String, passedInPageNumber: String = "1", _ completion: @escaping (Result<[Article]>) -> Void) {
        let articleRequest = makeRequest(for: .category(categoryIn: passedInCategory, pageNumber: passedInPageNumber))
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            
            do {
                _ = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch {
                print(error.localizedDescription)
            }
            
            // If there's data
            guard let safeData = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            
            // To decode data
            guard let result = try? JSONDecoder().decode(ArticleList.self, from: safeData) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            
            // Modify content field here to remove the [+123 chars]
            let modifiedArticles = result.articles.map { article -> Article in
                var modifiedArticle = article
                if var content = modifiedArticle.content {
                    if let range = content.range(of: "\\[\\+\\d+ chars\\]", options: .regularExpression) {
                        content.replaceSubrange(range, with: "SEE MORE")
                    }
                    modifiedArticle.content = content
                }
                return modifiedArticle
            }
            
            let modifiedResult = ArticleList(articles: modifiedArticles)
            
            DispatchQueue.main.async {
                completion(Result.success(modifiedResult.articles))
            }
        }
        task.resume()
    }
    
    func getSearchArticles(passedInQuery: String, _ completion: @escaping (Result<[Article]>) -> Void) {
        let articleRequest = makeRequest(for: .search(q: passedInQuery))
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            
            guard let safeData = data else {
                return completion(Result.failure(EndPointError.noData))
            }
            
            guard let result = try? JSONDecoder().decode(ArticleList.self, from: safeData) else {
                return completion(Result.failure(EndPointError.couldNotParse))
            }
            
            let articles = result.articles
            
            DispatchQueue.main.async {
                completion(Result.success(articles))
            }
        }
        task.resume()
    }
}
