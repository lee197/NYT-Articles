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

enum ArticlesRankingType:String {
    case email = "emailed"
    case view = "viewed"
    case share = "shared"
}

protocol ArticleFetchingObservable: class {
    func  requestData(type: ArticlesRankingType) -> Observable<Articles>
}

final class APIManager: ArticleFetchingObservable {
    static let shared = APIManager()

    func requestData(type: ArticlesRankingType) -> Observable<Articles> {
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/\(type.rawValue)/7.json?api-key=dylOnQnYUzEF1B9MTYYHM0MyffMPBZRi"
        let urlRequest = URLRequest(url: URL(string: urlString)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                if let data = data ,let responseCode = response as? HTTPURLResponse {
                    do {
                        let decoder = JSONDecoder()
                        
                        if responseCode.statusCode == 200 {
                            let value = try decoder.decode(Articles.self, from: data)
                            return observer.onNext(value)
                        }
                    }
                    catch let parseJSONError {
                        observer.onError(error!)
                        print("error on parsing request to JSON : \(parseJSONError)")
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
