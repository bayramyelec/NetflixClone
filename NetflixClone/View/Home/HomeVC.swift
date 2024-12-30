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
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return CompositionalLayoutHelper.headerViewLayout()
            case 1: return CompositionalLayoutHelper.popularCompositionalLayout()
            case 2: return CompositionalLayoutHelper.topRatedCompositionalLayout()
            case 3: return CompositionalLayoutHelper.popularCompositionalLayout()
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
        reloadData()
    }
    
}

extension HomeVC {
    func setup(){
        setupUI()
    }
    func setupUI(){
        view.backgroundColor = .black
        setupCollectionView()
    }
    func setupCollectionView(){
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collectionView.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: TopRatedCollectionViewCell.identifier)
        collectionView.register(UpComingCollectionViewCell.self, forCellWithReuseIdentifier: UpComingCollectionViewCell.identifier)
        collectionView.register(HeaderViewCollectionViewCell.self, forCellWithReuseIdentifier: HeaderViewCollectionViewCell.identifier)
        collectionView.register(TitleView.self, forSupplementaryViewOfKind: TitleView.kind, withReuseIdentifier: TitleView.identifier)
    }
    func reloadData(){
        viewModel.fetchPopularMovies()
        viewModel.fetchTopRatedMovies()
        viewModel.fetchUpcomingMovies()
        viewModel.reloadPopular = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.reloadTopRated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.reloadUpcoming = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.headerList.count
        } else if section == 1 {
            return viewModel.popularList.count
        } else if section == 2 {
            return viewModel.topRatedList.count
        } else if section == 3 {
            return viewModel.upcomingList.count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCollectionViewCell.identifier, for: indexPath) as! HeaderViewCollectionViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
            let item = viewModel.popularList[indexPath.row]
            cell.titleLabel.text = item.title
            cell.loadImage(url: item.posterPath)
            return cell
        } else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCollectionViewCell.identifier, for: indexPath) as! TopRatedCollectionViewCell
            let item = viewModel.topRatedList[indexPath.row]
            cell.loadImage(url: item.posterPath)
            return cell
        } else if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpComingCollectionViewCell.identifier, for: indexPath) as! UpComingCollectionViewCell
            let item = viewModel.upcomingList[indexPath.row]
            cell.loadImage(url: item.posterPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            let supView = collectionView.dequeueReusableSupplementaryView(ofKind: TitleView.kind, withReuseIdentifier: TitleView.identifier, for: indexPath) as! TitleView
            supView.configure(with: "Popular")
            
            return supView
        } else if indexPath.section == 2 {
            let supView = collectionView.dequeueReusableSupplementaryView(ofKind: TitleView.kind, withReuseIdentifier: TitleView.identifier, for: indexPath) as! TitleView
            supView.configure(with: "Top Rated")
            return supView
        } else if indexPath.section == 3 {
            let supView = collectionView.dequeueReusableSupplementaryView(ofKind: TitleView.kind, withReuseIdentifier: TitleView.identifier, for: indexPath) as! TitleView
            supView.configure(with: "Up Coming")
            return supView
        }
        return TitleView()
    }
    
}
