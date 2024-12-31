//
//  MainViewModel.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 29.12.2024.
//

import UIKit

class MainViewModel {
    
    var headerList: [UIImage?] = [UIImage(named: "header")]
    
    var popularList: [MovieResult] = [] {
        didSet {
            reloadPopular?()
        }
    }
    
    var topRatedList: [MovieResult] = [] {
        didSet {
            reloadTopRated?()
        }
    }
    
    var upcomingList: [MovieResult] = [] {
        didSet {
            reloadUpcoming?()
        }
    }
    
    var trendingList: [MovieResult] = [] {
        didSet {
            reloadTrending?()
        }
    }
    
    var downloadList: [DownloadModel] = [] {
        didSet {
            reloadDownloaded?()
        }
    }
    
    var reloadPopular: (() -> Void)?
    var reloadTopRated: (() -> Void)?
    var reloadUpcoming: (() -> Void)?
    var reloadTrending: (() -> Void)?
    var reloadDownloaded: (() -> Void)?
    
    func fetchPopularMovies() {
        NetworkManager.shared.getPopular { [weak self] result in
            switch result {
            case .success(let movieModel):
                self?.popularList = movieModel.results
                self?.reloadPopular?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchTopRatedMovies() {
        NetworkManager.shared.getTopRated { [weak self] result in
            switch result {
            case .success(let movieModel):
                self?.topRatedList = movieModel.results
                self?.reloadTopRated?()
            case .failure(let error):
                print("Error fetching top-rated movies: \(error)")
            }
        }
    }
    
    func fetchUpcomingMovies() {
        NetworkManager.shared.getUpcoming { [weak self] result in
            switch result {
            case .success(let movieModel):
                self?.upcomingList = movieModel.results
                self?.reloadUpcoming?()
            case .failure(let error):
                print("Error fetching upcoming movies: \(error)")
            }
        }
    }
    
    func fetchTrendingMovies() {
        NetworkManager.shared.fetchTrending { [weak self] result in
            switch result {
            case .success(let movieModel):
                self?.trendingList = movieModel.results
                self?.reloadTrending?()
            case .failure(let error):
                print("Error fetching trending movies: \(error)")
            }
        }
    }
    
    func addMovieToDownloadList(image: String, title: String) {
        let item = DownloadModel(image: image, title: title)
        if !downloadList.contains(where: { $0.title == item.title }) {
            downloadList.append(item)
            print("Added: \(item.title)")
            reloadDownloaded?()
            print(downloadList.count)
        } else {
            print("Already exists: \(item.title)")
        }
    }
    
    func removeMovieFromDownloadList(title: String) {
        downloadList.removeAll(where: { $0.title == title })
        reloadDownloaded?()
    }
    
}
