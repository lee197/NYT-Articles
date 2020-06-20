//
//  ArticlesCell.swift
//  NYT-Articles
//
//  Created by 李祺 on 20/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit
class ArticlesCell: UITableViewCell {
    let sectionLabel = UILabel()
    let titleLabel = UILabel()
    let abstrctLabel = UILabel()
    let titleImageView = ScaleAspectFitImageView.init(image: UIImage(named: "blank"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(sectionLabel)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        sectionLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        sectionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        sectionLabel.numberOfLines = 0
        sectionLabel.font = UIFont(name: "Avenir-Book", size: 12)
        sectionLabel.textColor = UIColor.lightGray

        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        contentView.addSubview(abstrctLabel)
        contentView.addSubview(titleImageView)

        abstrctLabel.translatesAutoresizingMaskIntoConstraints = false
        abstrctLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        abstrctLabel.bottomAnchor.constraint(equalTo: titleImageView.topAnchor).isActive = true
        abstrctLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        abstrctLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        abstrctLabel.numberOfLines = 0
        abstrctLabel.font = UIFont(name: "Avenir-Book", size: 12)
        abstrctLabel.textColor = UIColor.lightGray
        
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleImageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleImageView.topAnchor.constraint(equalTo: abstrctLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
