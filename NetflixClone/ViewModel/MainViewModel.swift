//
//  MainViewModel.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 29.12.2024.
//

import Foundation

class MainViewModel {
    
    var popularList: [MovieResult] = [] {
        didSet {
            reloadPopular?()
        }
    }
    
    var reloadPopular: (() -> Void)?
    
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
    
}
