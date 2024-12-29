//
//  HomeVC.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private let headerView = UIImageView()
    private let iconImageView = UIImageView()
    private let segmentedController = UISegmentedControl(items: ["TV Shows", "Movies", "My List"])
    private let gradientLayer = CAGradientLayer()
    private let playButton = UIButton()
    private let infoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = headerView.bounds
    }
}

extension HomeVC {
    func setup(){
        setupUI()
    }
    func setupUI(){
        view.backgroundColor = .black
        
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.7).cgColor, UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        headerView.layer.addSublayer(gradientLayer)
        
        view.addSubview(headerView)
        headerView.image = UIImage(named: "header")
        headerView.contentMode = .scaleAspectFill
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        headerView.addSubview(playButton)
        playButton.setTitle("Play", for: .normal)
        playButton.setImage(UIImage(systemName: ""), for: .normal)
        playButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        playButton.setTitleColor(.white, for: .normal)
        playButton.layer.cornerRadius = 10
        playButton.clipsToBounds = true
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.borderWidth = 1
        playButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(90)
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.25)
        }
        
        headerView.addSubview(infoButton)
        infoButton.setTitle("Info", for: .normal)
        infoButton.setImage(UIImage(systemName: ""), for: .normal)
        infoButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        infoButton.setTitleColor(.white, for: .normal)
        infoButton.layer.cornerRadius = 10
        infoButton.clipsToBounds = true
        infoButton.layer.borderColor = UIColor.white.cgColor
        infoButton.layer.borderWidth = 1
        infoButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-90)
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.25)
        }
        
        
        view.addSubview(iconImageView)
        iconImageView.image = UIImage(named: "logo")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(10)
            make.height.equalTo(view.snp.width).multipliedBy(0.1)
            make.width.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        view.addSubview(segmentedController)
        segmentedController.selectedSegmentIndex = 0
        segmentedController.backgroundColor = .clear
        segmentedController.selectedSegmentTintColor = .clear
        segmentedController.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedController.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedController.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(iconImageView.snp.right)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}
