//
//  Networking.swift
//  NYT-Articles
//
//  Created by 李祺 on 19/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum RequestError: Error {
    case unknownError
    case connectionError
    case invalidRequest
    case notFound
    case invalidResponse
    case authorizationError(String)
    case serverError
    case parseError
}

enum ArticlesRankingType:String {
    
    case email = "emailed"
    case view = "viewed"
    case share = "shared"
}

protocol ArticleFetchingProtocol {
    func  requestData(type: ArticlesRankingType, completion: @escaping (Result<Articles, RequestError>) -> Void)
}

class APIManager: ArticleFetchingProtocol {
    
    func requestData(type: ArticlesRankingType, completion: @escaping (Result<Articles, RequestError>) -> Void) {
        
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/\(type.rawValue)/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi"
        
        let urlRequest = URLRequest(url: URL(string: urlString)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let _ = error {
                completion(.failure(.connectionError))
                return
            }
            
            
            if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
                    
                    let decoder = JSONDecoder()
                    
                    switch responseCode.statusCode {
                        
                    case 200:
                        
                        let value = try decoder.decode(Articles.self, from: data)
                        print(value)
                        completion(.success(value))
                        
                    case 400...499:
                        
                        let errorDes = try decoder.decode(String.self, from: data)
                        completion(.failure(.authorizationError(errorDes)))
                        
                    case 500...599:
                        
                        completion(.failure(.serverError))
                        
                    default:
                        
                        completion(.failure(.unknownError))
                        break
                    }
                }
                catch let parseJSONError {
                    completion(.failure(.parseError))
                    print("error on parsing request to JSON : \(parseJSONError)")
                }
            }
            
        }.resume()
    }
}
