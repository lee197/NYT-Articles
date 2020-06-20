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
}

class ArticleViewModel {
    let articles: BehaviorRelay<[ArticleResult]> = BehaviorRelay(value: .init())
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let error: BehaviorRelay<ArticleError> = BehaviorRelay(value: .clientError("init error"))
    private let disposeable = DisposeBag()
    private let apiClient: ArticleFetchingProtocol
    
    init(apiClient: ArticleFetchingProtocol = APIManager()) {
        self.apiClient = apiClient
    }
    
    
    func fetchData(sortType: ArticlesRankingType){
        self.apiClient.requestData(type: sortType){ [weak self] result in
            guard let self = self else {
                return
            }
            
            self.isLoading.accept(false)
            
            switch result {
                
            case .success(let news):
                
                self.articles.accept(news.results)
                
            case .failure(let failure):
                
                switch failure {
                    
                case .connectionError:
                    
                    self.error.accept(.clientError("Check your Internet connection."))
                    
                case .authorizationError(let errorString):
                    
                    self.error.accept(.serverMessage(errorString))
                    
                default:
                    
                    self.error.accept(.serverMessage("Unknown Error"))
                }
            }
        }
    }
}


