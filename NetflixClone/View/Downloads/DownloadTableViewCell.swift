//
//  DownloadTableViewCell.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 31.12.2024.
//


import UIKit
import Kingfisher

class DownloadTableViewCell: UITableViewCell {
    
    static let identifier: String = "cell"
    
    let titleLabel = UILabel()
    let customImageView = UIImageView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        contentView.backgroundColor = .black
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
            make.left.equalTo(customImageView.snp.right)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
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
