//
//  UpComingCollectionViewCell.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 30.12.2024.
//

import UIKit

class UpComingCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "UpComingCollectionViewCell"
    
    let customImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        contentView.addSubview(customImageView)
        
        customImageView.contentMode = .scaleAspectFill
        customImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(5)
            make.top.bottom.equalToSuperview().offset(20)
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
