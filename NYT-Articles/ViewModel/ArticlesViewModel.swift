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

enum ArticleError {
    case serverMessage(String)
    case clientError(String)
    case initError
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}

struct ArticleViewModel: ViewModelType {
    let input: Input
    let output: Output
    
    private let disposeable = DisposeBag()
    private let apiClient: ArticleFetchingObservable
    let rankingType: ArticlesRankingType
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let articles: PublishRelay<[ArticleResult]>
        let error: PublishRelay<String>
    }
    
    init(apiClient: ArticleFetchingObservable = APIManager(), rankingType: ArticlesRankingType) {
        self.apiClient = apiClient
        self.rankingType = rankingType
        let errorRelay = PublishRelay<String>()
        let articleRelay = PublishRelay<[ArticleResult]>()
        
        apiClient.requestData(type: rankingType).subscribe(
            onNext: { article in
                articleRelay.accept(article.results)
        },
            onError: { error in
                print(error.localizedDescription)
                errorRelay.accept(error.localizedDescription)
        },
            onCompleted: {
                print("Completed event.")
        }).disposed(by: disposeable)
        
        self.input = Input(reload: PublishRelay<Void>())
        self.output = Output(articles: articleRelay, error: errorRelay)
    }
}

