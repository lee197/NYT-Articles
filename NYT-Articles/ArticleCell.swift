//
//  ArticleCell.swift
//  NYT-Articles
//
//  Created by 李祺 on 19/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    var articleImage : UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    var titleLabel : UILabel  { createLabel(with: 16) }
    var abstractionLabel: UILabel { createLabel(with: 14) }
    var sectionLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.backgroundColor = .red
        return label
        
    }
    
    var cellArticle : ArticleResult! {
        didSet {
            self.titleLabel.text = cellArticle.title
            self.abstractionLabel.text = cellArticle.abstract
            self.sectionLabel.text = cellArticle.section
        }
    }
    
    func createLabel(with fontSize:CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.numberOfLines = 0
        label.backgroundColor = .red
        return label
    }
    var initialConstraints = [NSLayoutConstraint]()
    override func awakeFromNib() {
        self.addSubview(articleImage)
        self.addSubview(titleLabel)
        self.addSubview(abstractionLabel)
        self.addSubview(sectionLabel)
        initialConstraints.removeAll()
        //        setArticleImageConstraints()
        //        setTitleLabelConstraints()
        //        setAbstractionLabelConstraints()
        setSectionLabelConstraints()
    }
    
    func setArticleImageConstraints() {
        initialConstraints.append(contentsOf: [
            articleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            articleImage.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            articleImage.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setTitleLabelConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: self.sectionLabel.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        initialConstraints.append(contentsOf: titleLabelConstraints)
    }
    
    func setAbstractionLabelConstraints() {
        let abstractionLabelConstraints = [
            abstractionLabel.topAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: 10),
            abstractionLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            abstractionLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        initialConstraints.append(contentsOf: abstractionLabelConstraints)
    }
    
    func setSectionLabelConstraints() {
        let sectionLabelConstraints = [
            sectionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            sectionLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20),
            sectionLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        initialConstraints.append(contentsOf: sectionLabelConstraints)
        NSLayoutConstraint.activate(initialConstraints)
    }
}
