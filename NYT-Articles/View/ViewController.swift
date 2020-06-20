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

class ViewController: UIViewController, UIScrollViewDelegate {
    var articlesViewModel = ArticleViewModel()
    private let disposeBag = DisposeBag()
    private let rankingFactor: ArticlesRankingType
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
        self.view.addBlurArea(area: self.view.frame, style: .dark)
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.register(ArticlesCell.self, forCellReuseIdentifier: "aCell")
        articlesViewModel.fetchData(sortType: self.rankingFactor)
        setupBinding()
    }
    
    private func setupBinding(){
        
        articlesViewModel.articles.observeOn(MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: "aCell", cellType: ArticlesCell.self)) {  (row,article,cell) in
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
            let vc = ArticleDetailViewController(urlString: self.articlesViewModel.articles.value[indexPath.row].url)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: disposeBag)
    }
}

extension UIView {
    func addBlurArea(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        container.alpha = 0.9
        self.insertSubview(container, at: 1)
    }
}
