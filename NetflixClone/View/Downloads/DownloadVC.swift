//
//  DownloadVC.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit

class DownloadVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension DownloadVC {
    func setup(){
        setupUI()
    }
    func setupUI(){
        view.backgroundColor = .black
    }
}
