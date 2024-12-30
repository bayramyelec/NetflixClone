//
//  HomeCollectionViewCell.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 29.12.2024.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
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
    
    func randomFont() -> UIFont {
        let fontNames = [
            "HelveticaNeue",
            "Arial",
            "Georgia",
            "Courier",
            "TimesNewRomanPS",
            "Verdana",
            "MarkerFelt-Thin",
            "Palatino-Bold"
        ]
        
        let randomFontName = fontNames.randomElement()!
        let randomFontSize = CGFloat(Int.random(in: 18...22))
        
        return UIFont(name: randomFontName, size: randomFontSize) ?? .systemFont(ofSize: randomFontSize)
    }
    
    func setup(){
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.frame = contentView.bounds
        customImageView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(customImageView)
        customImageView.contentMode = .scaleAspectFill
        customImageView.layer.cornerRadius = contentView.frame.width * 0.5
        customImageView.clipsToBounds = true
        customImageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = randomFont()
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom).inset(20)
            make.left.right.equalToSuperview()
        }
    }
    
    func loadImage(url: String){
        let mainUrl = "https://image.tmdb.org/t/p/w500"
        if let imageUrl = URL(string: mainUrl + url){
            print(imageUrl)
            customImageView.kf.setImage(with: imageUrl)
        }
    }
    
}
