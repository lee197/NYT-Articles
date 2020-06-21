//
//  ViewController.swift
//  NYT-Articles
//
//  Created by 李祺 on 19/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleListViewController: UIViewController, UIScrollViewDelegate {
    private var articlesViewModel = ArticleViewModel(rankingType: .email)
    private let rankingFactor: ArticlesRankingType
    private let disposeBag = DisposeBag()
    private weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        self.tableView = tableView
    }
    
    init(rankingFactor: ArticlesRankingType) {
        self.rankingFactor = rankingFactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        articlesViewModel = ArticleViewModel(rankingType: rankingFactor)
        
        tableView.register(ArticlesCell.self, forCellReuseIdentifier: "aCell")
        setupBinding()
        setupErrorBinding()
    }
    
    private func setupBinding(){
        
        articlesViewModel.output
            .articles
            .bind(to: tableView.rx.items(cellIdentifier: "aCell", cellType: ArticlesCell.self)) {  (row,article,cell) in
                cell.titleLabel.text = article.title
                cell.sectionLabel.text = article.section
                cell.abstrctLabel.text = article.abstract
                cell.titleImageView.downloaded(from: article.imageURL, contentMode: .scaleAspectFit)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else {
                return
            }
            self.tableView.deselectRow(at: indexPath, animated: true)
            let article: ArticleResult = try! self.tableView.rx.model(at: indexPath)
            let vc = ArticleDetailViewController(urlString: article.imageURL)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: disposeBag)
    }
    
    private func setupErrorBinding() {
        articlesViewModel
            .output
            .error.asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] error in
                guard let self = self else {
                    return
                }
                self.showAlert(alertMessage: error.description)
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlert(alertMessage:String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
