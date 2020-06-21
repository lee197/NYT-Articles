//
//  ArticleViewModelTest.swift
//  NYT-ArticlesTests
//
//  Created by 李祺 on 21/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import NYT_Articles

class ArticleViewModelTest: XCTestCase {
    var viewModel : ArticleViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    fileprivate var service : MockArticleFetchingService!
    
    override func setUp() {
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.service = MockArticleFetchingService()
        self.viewModel = ArticleViewModel(apiClient: service, rankingType: .email)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchWithError() {
        
//        let articles = scheduler.createObserver(Articles.self)
        let error = scheduler.createObserver(String.self)
        
        service.articles = nil
        self.viewModel
            .output
            .error
            .asDriver(onErrorJustReturn: "")
            .drive(error)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(error.events, [.next(10, "No converter")])
    }
}

fileprivate class MockArticleFetchingService: ArticleFetchingObservable {
    
    var articles : Articles?
    
    func requestData(type: ArticlesRankingType) -> Observable<Articles> {
        
        if let articles = articles {
            return Observable.just(articles)
        } else {
            return Observable.error(ErrorResult.custom(string: "error here"))
            
        }
    }
}

class DataGenerator {
    
    static func finishFetchData() -> Articles {
        let fileName = "sample"
        let path = Bundle.main.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let articlesFromFile = try! decoder.decode(Articles.self, from: data)
        return articlesFromFile
    }
}

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
