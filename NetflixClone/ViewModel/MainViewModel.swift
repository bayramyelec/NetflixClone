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
    
    var reloadPopular: (() -> Void)?
    var reloadTopRated: (() -> Void)?
    var reloadUpcoming: (() -> Void)?
    
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
    
}
