//
//  APICaller.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 12.09.2023.
//

import Foundation

final class NetworkManager {
    //singleton
    static let shared = NetworkManager()
    
    let urlSession = URLSession.shared
    let baseURL = "https://newsapi.org/v2/"
    let APIKEY = "51cfe807e03943b881d6f9642810cae0"
    
    
    //Everything /v2/everything – search every article published by over 80,000 different sources large and small in the last 5 years. This endpoint is ideal for news analysis and article discovery.
    //Top headlines /v2/top-headlines – returns breaking news headlines for countries, categories, and singular publishers. This is perfect for use with news tickers or anywhere you want to use live up-to-date news headlines.
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
        
        // Get the HTTP Request Method
        func HTTPRequestMethod() -> String {
            return "GET"
        }
        
        // Getting the header
        func getHeaders(apiKey: String) -> [String: String] {
            
            return ["Accept": "application/json",
                    "Content-Type": "application/json",
                    "Authorization": "X-Api-Key \(apiKey)",
                    "Host": "newsapi.org"
            ]
        }
        
        // Get the parameters for the call
        func getParameters() -> [String: String] {
            switch self {
            case .articles:
                return ["country": "us"
                ]
            case .category(let categoryIn, let pageNum):
                return ["country": "us",
                        "category": categoryIn,
                        "page": pageNum
                ]
            case .search(let qInput):
                return ["q": qInput
                ]
            }
        }
        
        // Converting paramters to actual url string
        func parametersToString() -> String {
            let parameterArray = getParameters().map{ key, value in
                return "\(key)=\(value)"
            }
            
            return parameterArray.joined(separator: "&")
        }
    }
    
    enum Result<T> {
        case success(T?)
        case failure(Error)
    }
    
    enum EndPointError: Error {
        case couldNotParse
        case noData
    }
    
    private func makeRequest(for endPoint: EndPoints) -> URLRequest {
        let path = endPoint.getPath() // Get the first part of URL
        let stringParams = endPoint.parametersToString()
        let fullURL = URL(string: baseURL.appending("\(path)?\(stringParams)"))
        var request = URLRequest(url: fullURL!)
        request.httpMethod = endPoint.HTTPRequestMethod()
        request.allHTTPHeaderFields = endPoint.getHeaders(apiKey: APIKEY)
        return request
    }
    
    // Setting the default as page one.
    func getArticles(passedInCategory: String, passedInPageNumber: String="1", _ completion: @escaping (Result<[Article]>) -> Void)  {
        let articleRequest = makeRequest(for: .category(categoryIn: passedInCategory, pageNumber: passedInPageNumber))
        //print(articleRequest)
        
        let task = urlSession.dataTask(with: articleRequest) { (data, response, error) in
            // If error
            if let error = error {
                return completion(Result.failure(error))
            }
            
            do {
                // Testing to see if got the proper json back
                // let jsonObject = try JSONSerialization.jsonObject(with: data!, options: [])
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
            
            let articles = result.articles
            
            DispatchQueue.main.async {
                completion(Result.success(articles))
                //print("Articles Count: \(result.articles.count)")
                //print(result.articles)
            }
        }
        task.resume()
    }
    
    func getSearchArticles(passedInQuery: String, _ completion: @escaping (Result<[Article]>) -> Void)  {
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
