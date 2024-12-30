//
//  HeaderView.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 30.12.2024.
//

import UIKit
import SnapKit

class TitleView: UICollectionReusableView {
    
    static let identifier = "HeaderView"
    static let kind = "Header"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String){
        titleLabel.text = title
    }
    
}
