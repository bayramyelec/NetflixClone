//
//  HomeVC.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit
import SnapKit
import Kingfisher

class HomeVC: UIViewController {
    
    private let headerView = UIImageView()
    private let iconImageView = UIImageView()
    private let segmentedController = UISegmentedControl(items: ["TV Shows", "Movies", "My List"])
    private let gradientLayer = CAGradientLayer()
    private let playButton = UIButton()
    private let infoButton = UIButton()
    
    private var collectionView: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return CompositionalLayoutHelper.makeCompositionalLayout()
            default: return nil
            }
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
        
    }()
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchPopularMovies()
        viewModel.reloadPopular = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
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
            make.bottom.equalToSuperview().inset(10)
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
            make.bottom.equalToSuperview().inset(10)
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
        
        setupCollectionView()
    }
    func setupCollectionView(){
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.popularList.count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
            let item = viewModel.popularList[indexPath.row]
            cell.titleLabel.text = item.title
            cell.loadImage(url: item.posterPath)
            return cell
        }
        return HomeCollectionViewCell()
    }
}
