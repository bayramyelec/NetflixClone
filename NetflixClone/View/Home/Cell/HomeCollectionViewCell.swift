//
//  HomeCollectionViewCell.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 29.12.2024.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCollectionViewCell"
    
    let titleLabel = UILabel()
    let customImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradientLayer.frame = contentView.bounds
        customImageView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(customImageView)
        customImageView.contentMode = .scaleAspectFill
        customImageView.layer.cornerRadius = contentView.frame.width * 0.4
        customImageView.clipsToBounds = true
        customImageView.layer.borderColor = UIColor.white.cgColor
        customImageView.layer.borderWidth = 1
        customImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.85)
        }
        
        
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 17, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom).inset(10)
            make.left.right.equalToSuperview()
        }
    }
    
    func loadImage(url: String){
        let mainUrl = "https://image.tmdb.org/t/p/w500"
        if let imageUrl = URL(string: mainUrl + url){
            customImageView.kf.setImage(with: imageUrl)
        }
    }
    
}
