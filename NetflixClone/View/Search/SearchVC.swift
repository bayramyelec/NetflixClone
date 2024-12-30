//
//  SearchVC.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit

class SearchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
extension SearchVC {
    func setup(){
        setupUI()
    }
    func setupUI(){
        view.backgroundColor = .black
    }
}
