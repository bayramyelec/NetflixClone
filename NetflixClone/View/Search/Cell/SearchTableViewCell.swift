//
//  SearchTableViewCell.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 31.12.2024.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
    static let identifier: String = "cell"
    
    let titleLabel = UILabel()
    let customImageView = UIImageView()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        contentView.addSubview(customImageView)
        customImageView.contentMode = .scaleAspectFill
        customImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.2)
        }
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(customImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.6)
            make.height.equalTo(20)
        }
        contentView.addSubview(descriptionLabel)
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 6
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(customImageView.snp.right)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.6)
        }
    }
    
    func loadImage(url: String){
        let mainUrl = "https://image.tmdb.org/t/p/w500"
        if let imageUrl = URL(string: mainUrl + url){
            print("image url: \(imageUrl)")
            customImageView.kf.setImage(with: imageUrl)
        }
    }
    
}
