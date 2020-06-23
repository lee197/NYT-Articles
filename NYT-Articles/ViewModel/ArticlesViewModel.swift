//
//  ArticlesViewModel.swift
//  NYT-Articles
//
//  Created by 李祺 on 19/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
    
    var localizedDescription: String {
        switch self {
        case .network(let value):   return value
        case .parser(let value):    return value
        case .custom(let value):    return value
        }
    }
}

struct ArticleViewModel {
    let input: Input
    let output: Output
    
    private let disposeable = DisposeBag()
    private let apiClient: ArticleFetchingObservable
    let rankingType: ArticlesRankingType
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let articles: Driver<[ArticleResult]>
        let error: Driver<String>
    }
    
    
    init(apiClient: ArticleFetchingObservable = APIManager.shared, rankingType: ArticlesRankingType) {
        self.apiClient = apiClient
        self.rankingType = rankingType
        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        
        let articles = reloadRelay
            .asObservable()
            .flatMapLatest({ apiClient.requestData(type: rankingType) })
            .map({ $0.results })
            .asDriver { (error) -> Driver<[ArticleResult]> in
                errorRelay.accept((error as? ErrorResult)?.localizedDescription ?? error.localizedDescription)
                return Driver.just([])
        }
        self.input = Input(reload: reloadRelay)
        self.output = Output(articles: articles, error: errorRelay.asDriver(onErrorJustReturn: "error happened"))
    }
}
